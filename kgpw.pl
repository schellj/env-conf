#! /usr/bin/env perl

use List::Util qw(max sum);
use DDP;
use POSIX qw(floor);

my %_PODS;
my %_STATUS_ABBR = (
    Running => 'Run',
    CrashLoopBackOff => 'CLB',
    Terminating => 'Trm',
    Pending => 'Pnd',
    Evicted => 'Evc',
    Completed => 'Cmp',
    RunContainerError => 'RCE',
    ContainerCreating => 'Cre',
    PodInitializing => 'Ini',
    CreateContainerConfigError => 'CCC',
    OOMKilled => 'OOM',
);
my %_STATUS_BACKGROUND_COLOR = (
    0 => {
        Running => "\e[48;2;0;120;0m",
        CrashLoopBackOff => "\e[48;2;170;0;170m",
        Terminating => "\e[48;2;120;0;0m",
        Pending => "\e[48;2;20;60;20m",
        Evicted => "\e[48;2;50;50;50m",
        Completed => "\e[48;2;0;0;120m",
        RunContainerError => "\e[48;2;170;0;170m",
        ContainerCreating => "\e[48;2;0;170;170m",
        PodInitializing => "\e[48;2;0;170;170m",
        CreateContainerConfigError => "\e[48;2;170;0;170m",
        OOMKilled => "\e[48;2;170;0;170m",
    },
    1 => {
        Running => "\e[48;2;20;140;20m",
        CrashLoopBackOff => "\e[48;2;190;20;190m",
        Terminating => "\e[48;2;140;20;20m",
        Pending => "\e[48;2;40;80;40m",
        Evicted => "\e[48;2;70;70;70m",
        Completed => "\e[48;2;20;20;140m",
        RunContainerError => "\e[48;2;190;20;190m",
        ContainerCreating => "\e[48;2;20;190;190m",
        PodInitializing => "\e[48;2;20;190;190m",
        CreateContainerConfigError => "\e[48;2;190;20;190m",
        OOMKilled => "\e[48;2;190;20;190m",
    },
);
my %_STATUS_MAXES;
my %_DEFAULT_BACKGROUND_COLOR = (
    0 => "\e[48;2;20;20;20m",
    1 => "\e[48;2;40;40;40m",
);
my $_DEFAULT_FOREGROUND_COLOR = "\e[38;2;225;225;225m";
my $_HIGHLIGHT_FOREGROUND_COLOR = "\e[38;2;255;255;75m";
my %_CELL_FOREGROUND_COLOR = (
    0 => "\e[38;5;248m",
    1 => "\e[38;5;252m",
);
my $_CLEAR_REST = "\e[K";
my $_CLEAR_REST_AND_NEWLINE = "$_CLEAR_REST\n";
my $_RESET_COLORS = "\e[0m";

my $order = 0;
my $last_num_lines = 0;
while (<STDIN>) {
    chomp;
    my ($full_name, $container_status, $pod_status, $restarts, $age) = split /\s+/, $_;
    next
        if $full_name eq 'NAME';

    $full_name =~ /^(?<prefix>.+)-(?<id>.+)$/;
    my $pod_prefix = $+{prefix};
    my $pod_id = $+{id};
    $_PODS{$pod_prefix}{$pod_id} = {
        prefix => $pod_prefix,
        id => $pod_id,
        container_status => $container_status,
        pod_status => $pod_status,
        restarts => $restarts,
        age => $age,
        order => $_PODS{$pod_prefix}{$pod_id}{order} // $order++,
    };

    my ($output, $lines) = render($pod_prefix, $pod_id);
    _move_up_lines($last_num_lines);

    $last_num_lines = $lines;

    print STDERR $output;
}

exit 0;

sub render {
    my ($updated_pod_prefix, $updated_pod_id) = @_;
    my $terminal_columns = `tput cols`;
    chomp $terminal_columns;

    my %status_maxes;

    my @groups;
    foreach my $pod_prefix (sort { $a cmp $b } keys %_PODS) {
        $status_maxes{header} = max($status_maxes{header} // 0, length($pod_prefix));
        my @statuses = ({
            header => $pod_prefix,
        });

        foreach my $pod_id (sort {
            $_PODS{$pod_prefix}{$a}{order} <=> $_PODS{$pod_prefix}{$b}{order}
        } keys $_PODS{$pod_prefix}) {
            my $status = $_PODS{$pod_prefix}{$pod_id};

            %status_maxes = (
                %status_maxes,
                id => max($status_maxes{id} // 0, length($status->{id})),
                container_status => max($status_maxes{container_status} // 0, length($status->{container_status})),
                pod_status => max($status_maxes{pod_status} // 0, length($_STATUS_ABBR{$status->{pod_status}} // $status->{pod_status})),
                restarts => max($status_maxes{restarts} // 0, length($status->{restarts})),
                age => max($status_maxes{age} // 0, length($status->{age} eq '<invalid>' ? 'x' : $status->{age})),
            );

            push @statuses, { pod => $status };
        }

        push @groups, \@statuses;
    }

    my $num_pods_fit = floor(
        ($terminal_columns - $status_maxes{header} - 1)
            / (sum(@status_maxes{qw(id container_status pod_status restarts age)}, 4, 2)));

    my $buffer = '';
    my $first_line = 1;
    my $num_lines = 0;

    foreach my $group (@groups) {
        my @statuses;
        my $s = 0;
        while (my $status = shift @$group) {
            push @statuses, $status;

            next
                if defined $status->{header};

            if (@$group && ++$s % $num_pods_fit == 0) {
                push @statuses, { header => ' ' };
            }
        }

        my $i = 0;
        foreach my $status (@statuses) {
            if (defined $status->{header}) {
                unless ($first_line) {
                    $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE";
                    $num_lines++;
                }

                $i = $num_lines % 2 == 0 ? 1 : 0;
                $first_line = 0;

                $buffer .= $_DEFAULT_FOREGROUND_COLOR
                    . $_DEFAULT_BACKGROUND_COLOR{$i % 2 == 0 ? 1 : 0}
                    . sprintf "%-$status_maxes{header}s ", $status->{header};
            }
            else {
                $buffer .= (
                    $status->{pod}{prefix} eq $updated_pod_prefix && $status->{pod}{id} eq $updated_pod_id
                        ? $_HIGHLIGHT_FOREGROUND_COLOR
                        : $_DEFAULT_FOREGROUND_COLOR
                    ) . $_STATUS_BACKGROUND_COLOR{$i % 2 == 0 ? 1 : 0}{$status->{pod}{pod_status}}
                    . ' '
                    . join ' ',
                    sprintf("%$status_maxes{id}s", $status->{pod}{id}),
                    sprintf("%$status_maxes{container_status}s", $status->{pod}{container_status}),
                    sprintf("%$status_maxes{pod_status}s", $_STATUS_ABBR{$status->{pod}{pod_status}} || $status->{pod}{pod_status}),
                    sprintf("%$status_maxes{restarts}s", $status->{pod}{restarts}),
                    sprintf("%$status_maxes{age}s", $status->{pod}{age} eq '<invalid>' ? 'x' : $status->{pod}{age})
                    . ' ';
            }

            $i++;
        }
    }

    $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE$_RESET_COLORS";
    $num_lines++;

    return ($buffer, $num_lines);
}

sub _move_up_lines {
    my ($num_lines) = @_;

    print STDERR "\e[", $num_lines, "A"
        if $num_lines;

    return;
}
