#! /usr/bin/env perl

use List::Util qw(max sum);
use DDP;
use POSIX qw(floor);
use Getopt::Std;
use Time::Piece;
use Time::Seconds qw(ONE_MONTH ONE_DAY ONE_HOUR ONE_MINUTE);
use JSON::XS qw(decode_json);
use DateTime;
use Date::Parse;
use Try::Tiny;

my %_OPTS;
getopts('vhi:n:', \%_OPTS);
my $_INTERVAL = $_OPTS{i} // 10;
my $_NAMESPACE = $_OPTS{n} // 'default';

my %_PODS;
my %_STATUS_ABBR = (
    Completed => 'Comp',
    ContainerCreating => 'Cre',
    CrashLoopBackOff => 'CLB',
    CreateContainerConfigError => 'CCC',
    Error => 'Err',
    ErrImagePull => 'EIP',
    Evicted => 'Evc',
    Failed => "Fai",
    Init => 'Ini',
    NodeLost => 'NoL',
    OOMKilled => 'OOM',
    Pending => 'Pnd',
    PodInitializing => 'ini',
    RunContainerError => 'RCE',
    Running => 'Run',
    Terminating => 'Trm',
    Unknown => 'Unk',
    ImagePullBackOff => 'IPB',
    ContainerCannotRun => 'CCR',
    Succeeded => 'Suc',
);
my %_STATUS_BACKGROUND_COLOR = (
    0 => {
        Completed => "\e[48;2;0;0;120m",
        Succeeded => "\e[48;2;0;0;120m",
        ContainerCreating => "\e[48;2;0;170;170m",
        CrashLoopBackOff => "\e[48;2;170;0;170m",
        CreateContainerConfigError => "\e[48;2;170;0;170m",
        Error => "\e[48;2;170;0;170m",
        ErrImagePull => "\e[48;2;170;0;170m",
        Evicted => "\e[48;2;50;50;50m",
        Failed => "\e[48;2;60;60;60m",
        Init => "\e[48;2;20;60;20m",
        NodeLost => "\e[48;2;170;0;170m",
        OOMKilled => "\e[48;2;170;0;170m",
        Pending => "\e[48;2;20;60;20m",
        PodInitializing => "\e[48;2;0;170;170m",
        RunContainerError => "\e[48;2;170;0;170m",
        Running => "\e[48;2;0;120;0m",
        Terminating => "\e[48;2;120;0;0m",
        Unknown => "\e[48;2;170;0;170m",
        ImagePullBackOff => "\e[48;2;170;0;170m",
        ContainerCannotRun => "\e[48;2;170;0;170m",
    },
    1 => {
        Completed => "\e[48;2;20;20;140m",
        Succeeded => "\e[48;2;20;20;140m",
        ContainerCreating => "\e[48;2;20;190;190m",
        CrashLoopBackOff => "\e[48;2;190;20;190m",
        CreateContainerConfigError => "\e[48;2;190;20;190m",
        Error => "\e[48;2;190;20;190m",
        ErrImagePull => "\e[48;2;190;20;190m",
        Evicted => "\e[48;2;70;70;70m",
        Failed => "\e[48;2;70;70;70m",
        Init => "\e[48;2;40;80;40m",
        NodeLost => "\e[48;2;190;20;190m",
        OOMKilled => "\e[48;2;190;20;190m",
        Pending => "\e[48;2;40;80;40m",
        PodInitializing => "\e[48;2;20;190;190m",
        RunContainerError => "\e[48;2;190;20;190m",
        Running => "\e[48;2;20;140;20m",
        Terminating => "\e[48;2;140;20;20m",
        Unknown => "\e[48;2;190;20;190m",
        ImagePullBackOff => "\e[48;2;190;20;190m",
        ContainerCannotRun => "\e[48;2;190;20;190m",
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
while (1) {
    my %new_pods;

    my $cmd_output = `kubectl get pods --namespace $_NAMESPACE -o json`;
    chomp $cmd_output;

    my $cmd_data;
    try {
        $cmd_data = decode_json($cmd_output);
    } catch {
        print STDERR "Unable to decode json: $_\n";
        exit 0;
    };

    unless ($cmd_data) {
        sleep $_INTERVAL;
        next;
    }

    foreach my $pod (@{$cmd_data->{items}}) {
        my $container_status = "@{[int(grep { $_->{ready} } @{$pod->{status}{containerStatuses}})]}/@{[int(@{$pod->{status}{containerStatuses}})]}";
        my $pod_generation = $pod->{metadata}{labels}{'pod-template-hash'} // '';
        my $pod_status = $pod->{status}{phase};
        my $restarts = sum(map { $_->{restartCount} } @{$pod->{status}{containerStatuses}});
        my $age = time - str2time($pod->{metadata}{creationTimestamp});
        my $full_name = $pod->{metadata}{name};

        my ($pod_prefix, $pod_id);
        if ($full_name =~ /-/) {
            $full_name =~ /^(?<prefix>.+)-(?<id>.+)$/;
            $pod_prefix = $+{prefix};
            $pod_id = $+{id};

            $pod_prefix =~ s/-$pod_generation//
                if $pod_generation;
            $pod_prefix =~ s/-\d+$//
                if grep { $_->{kind} eq 'Job' } @{$pod->{metadata}{ownerReferences}};
        }
        else {
            $pod_prefix = $full_name;
            $pod_id = '';
        }

        $new_pods{$pod_prefix}{$pod_id} = {
            prefix => $pod_prefix,
            generation => $pod_generation,
            id => $pod_id,
            container_status => $container_status,
            pod_status => $pod_status,
            restarts => $restarts,
            age => $age,
            order => $_PODS{$pod_prefix}{$pod_id}{order} // $order++,
        };

        $new_pods{$pod_prefix}{$pod_id}{is_updated}
            = grep { "$_PODS{$pod_prefix}{$pod_id}{$_}" ne "$new_pods{$pod_prefix}{$pod_id}{$_}" }
                grep { $_ ne 'age' } keys %{$new_pods{$pod_prefix}{$pod_id}};
    }

    %_PODS = %new_pods;

    _print_new_output(&{
        $_OPTS{v} ? _render_pods_verbose
            : $_OPTS{h} ? _render_pods_compact_horizontal
            : _render_pods_compact
    }(_group_pods()));

    sleep $_INTERVAL;
}

exit 0;

sub _group_pods {
    my @groups;
    foreach my $pod_prefix (sort { $a cmp $b } keys %_PODS) {
        my @statuses = ({
            header => $pod_prefix,
        });

        foreach my $pod_id (sort {
            $_PODS{$pod_prefix}{$b}{order} <=> $_PODS{$pod_prefix}{$a}{order}
        } keys %{$_PODS{$pod_prefix}}) {
            push @statuses, { pod => $_PODS{$pod_prefix}{$pod_id} };
        }

        push @groups, \@statuses;
    }

    return \@groups;
}

sub _num_pods_fit {
    my (%length_maxes) = @_;

    my $terminal_columns = `tput cols`;
    chomp $terminal_columns;

    return max(1, floor(
        ($terminal_columns - $length_maxes{header} - 1)
            / (sum(@length_maxes{qw(id prefix count total_containers container_status pod_status restarts age)}, 4, 2))));
}

sub _num_services_fit {
    my (%length_maxes) = @_;

    my $terminal_columns = `tput cols`;
    chomp $terminal_columns;

    my $service_width = sum(
        length(' '),
        $length_maxes{pod_status},
        length(' '),
        $length_maxes{total_containers},
        length('/'),
        $length_maxes{total_containers},
        length(' '),
        $length_maxes{restarts},
        length(' '),
        4,
        length(' '),
    );

    return (floor($terminal_columns / $service_width), $service_width);
}

sub _print_new_output {
    # Move to home position, clear screen, print output
    print STDERR "\e[H\e[J", shift;
}

sub _render_aggregation_compact {
    my ($aggregation, $num_lines, $num_aggregations, %length_maxes) = @_;

    my $average_age = $aggregation->{age} / $aggregation->{count};
    $average_age = $average_age > ONE_DAY ? sprintf("%.0f", $average_age / (ONE_DAY)) . 'd'
        : $average_age > ONE_HOUR ? sprintf("%.0f", $average_age / (ONE_HOUR)) . 'h'
        : $average_age > ONE_MINUTE ? sprintf("%.0f", $average_age / ONE_MINUTE) . 'm'
        : sprintf("%.0f", $average_age) . 's';

    return ''
        . ($aggregation->{is_updated} ? $_HIGHLIGHT_FOREGROUND_COLOR : $_DEFAULT_FOREGROUND_COLOR)
        . $_STATUS_BACKGROUND_COLOR{
            ($num_lines + $num_aggregations) % 2 == 0 ? 1 : 0}{$aggregation->{pod_status}} . ' '
        . sprintf(
            "%$length_maxes{pod_status}s ",
            $_STATUS_ABBR{$aggregation->{pod_status}} || $aggregation->{pod_status},
        )
        . sprintf("%$length_maxes{count}s ", $aggregation->{count})
        . sprintf("%$length_maxes{total_containers}s/", $aggregation->{running_containers})
        . sprintf("%$length_maxes{total_containers}s ", $aggregation->{total_containers})
        . sprintf("%$length_maxes{restarts}s ", $aggregation->{restarts})
        . sprintf("%4s ", $average_age);
}

sub _render_aggregation_compact_horizontal {
    my ($aggregation, $num_cells, $num_aggregations, %length_maxes) = @_;

    my $average_age = $aggregation->{age} / $aggregation->{count};
    $average_age = $average_age > ONE_DAY ? sprintf("%.0f", $average_age / (ONE_DAY)) . 'd'
        : $average_age > ONE_HOUR ? sprintf("%.0f", $average_age / (ONE_HOUR)) . 'h'
        : $average_age > ONE_MINUTE ? sprintf("%.0f", $average_age / ONE_MINUTE) . 'm'
        : sprintf("%.0f", $average_age) . 's';

    return ''
        . ($aggregation->{is_updated}
                      ? $_HIGHLIGHT_FOREGROUND_COLOR : $_DEFAULT_FOREGROUND_COLOR)
        . $_STATUS_BACKGROUND_COLOR{($num_cells + $num_aggregations) % 2 == 0 ? 1 : 0}{$aggregation->{pod_status}}
        . ' '
        . sprintf(
            "%$length_maxes{pod_status}s",
            $_STATUS_ABBR{$aggregation->{pod_status}} || $aggregation->{pod_status},
        ) . ' '
            . sprintf("%$length_maxes{total_containers}s", $aggregation->{running_containers}) . '/'
            . sprintf("%$length_maxes{total_containers}s", $aggregation->{total_containers}) . ' '
            . sprintf("%$length_maxes{restarts}s", $aggregation->{restarts}) . ' '
            . sprintf("%4s", $average_age) . ' ';
}

sub _render_pods_compact {
    my ($groups) = @_;

    my %group_aggregations;
    foreach my $group (@$groups) {
        my $group_header = shift @$group;

        foreach my $status (@$group) {
            _update_aggregation(\%group_aggregations, $group_header, $status);
        }
    }

    my %length_maxes;
    foreach my $prefix (keys %group_aggregations) {
        $length_maxes{prefix} = max($length_maxes{prefix} // 0, length($prefix));

        foreach my $aggregation (values %{$group_aggregations{$prefix}}) {
            $length_maxes{$_} = max($length_maxes{$_} // 0, length($aggregation->{$_}))
                for qw(count total_containers restarts);
            $length_maxes{pod_status} = max(
                $length_maxes{pod_status} // 0,
                length($_STATUS_ABBR{$aggregation->{pod_status}} || $aggregation->{pod_status}),
            );
        }
    }

    my $num_pods_fit = _num_pods_fit(%length_maxes);
    my $buffer = '';
    my $num_lines = 0;
    my $prefix_width = 16;

    foreach my $prefix (sort { $a cmp $b } keys %group_aggregations) {
        $buffer .= $_DEFAULT_FOREGROUND_COLOR
            . _render_prefix_compact_horizontal($prefix, $prefix_width);

        my $num_aggregations = 0;
        foreach my $aggregation (
            sort { $a->{pod_status} cmp $b->{pod_status} } values %{$group_aggregations{$prefix}}
        ) {
            if ($num_aggregations > 0 && ($num_aggregations % $num_pods_fit == 0)) {
                $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE"
                    . ' ' x ($prefix_width - 1);
                $num_lines++;
            }

            $buffer .= _render_aggregation_compact(
                $aggregation, $num_lines, $num_aggregations, %length_maxes);
            $num_aggregations++;
        }

        $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE$_RESET_COLORS$_CLEAR_REST";
        $num_lines++;
    }

    return ($buffer, $num_lines);
}

sub _render_pods_compact_horizontal {
    my ($groups) = @_;

    my %group_aggregations;
    foreach my $group (@$groups) {
        my $group_header = shift @$group;

        foreach my $status (@$group) {
            _update_aggregation(\%group_aggregations, $group_header, $status);
        }
    }

    my %length_maxes;
    foreach my $prefix (keys %group_aggregations) {
        $length_maxes{prefix} = max($length_maxes{prefix} // 0, length($prefix));

        foreach my $aggregation (values %{$group_aggregations{$prefix}}) {
            $length_maxes{$_} = max($length_maxes{$_} // 0, length($aggregation->{$_}))
                for qw(total_containers restarts);
            $length_maxes{pod_status} = max(
                $length_maxes{pod_status} // 0,
                length($_STATUS_ABBR{$aggregation->{pod_status}} || $aggregation->{pod_status}),
            );
        }
    }

    my @services;
    my $num_aggregations = 0;
    foreach my $prefix (sort { $a cmp $b } keys %group_aggregations) {
        $l = 1;
        $num_aggregations++;
        push @services, [
            $prefix,
            map({
                _render_aggregation_compact_horizontal($_, $l++, $num_aggregations, %length_maxes)
            } sort { $a->{pod_status} cmp $b->{pod_status} } values %{$group_aggregations{$prefix}}),
        ];
    }

    my ($num_services_fit, $service_width) = _num_services_fit(%length_maxes);

    my $num_services = 0;
    foreach my $service (@services) {
        $service->[0] = ($num_services++ % 2 == 0 ? "\e[48;2;30;30;30m" : "\e[48;2;60;60;60m") . _render_prefix_compact_horizontal($service->[0], $service_width);
    }

    my $buffer = '';
    my $num_lines = 0;
    while (@services) {
        my @chunk = splice @services, 0, $num_services_fit;

        $buffer .= $_DEFAULT_FOREGROUND_COLOR;

        my $done = 0;
        until ($done) {
            $done = 1;
            foreach my $service (@chunk) {
                $buffer .= shift(@$service) || ("$_RESET_COLORS$_CLEAR_REST" . sprintf("%-${service_width}s", ' '));

                $done = 0
                    if @$service;
            }

            if (@services || !$done) {
                $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE$_RESET_COLORS$_CLEAR_REST";
                $num_lines++;
            }
        }

        $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE$_RESET_COLORS$_CLEAR_REST"
            unless $done;
    }

    $buffer .= "$_RESET_COLORS$_CLEAR_REST";

    return ($buffer, $num_lines);
}

sub _render_pods_verbose {
    my ($groups) = @_;

    my %length_maxes;
    foreach my $group (@$groups) {
        foreach my $status (@$group) {
            %length_maxes = (
                %length_maxes,
                header => max($length_maxes{header} // 0, length($status->{header})),
                id => max($length_maxes{id} // 0, length($status->{pod}{id})),
                container_status => max(
                    $length_maxes{container_status} // 0, length($status->{pod}{container_status})),
                pod_status => max(
                    $length_maxes{pod_status} // 0,
                    length($_STATUS_ABBR{$status->{pod}{pod_status}} // $status->{pod}{pod_status}),
                ),
                restarts => max($length_maxes{restarts} // 0, length($status->{pod}{restarts})),
                age => max(
                    $length_maxes{age} // 0,
                    length($status->{pod}{age} eq '<invalid>' ? 'x' : $status->{pod}{age}),
                ),
            );
        }
    }

    my $num_pods_fit = _num_pods_fit(%length_maxes);

    my $buffer = '';
    my $first_line = 1;
    my $num_lines = 0;

    foreach my $group (@$groups) {
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
                    . sprintf "%-$length_maxes{header}s ", $status->{header};
            }
            else {
                $buffer .= (
                    $status->{pod}{is_updated}
                        ? $_HIGHLIGHT_FOREGROUND_COLOR
                        : $_DEFAULT_FOREGROUND_COLOR
                    ) . $_STATUS_BACKGROUND_COLOR{$i % 2 == 0 ? 1 : 0}{$status->{pod}{pod_status}}
                    . ' '
                    . join ' ',
                    sprintf("%$length_maxes{id}s", $status->{pod}{id}),
                    sprintf("%$length_maxes{container_status}s", $status->{pod}{container_status}),
                    sprintf(
                        "%$length_maxes{pod_status}s",
                        $_STATUS_ABBR{$status->{pod}{pod_status}} || $status->{pod}{pod_status},
                    ),
                    sprintf("%$length_maxes{restarts}s", $status->{pod}{restarts}),
                    sprintf(
                        "%$length_maxes{age}s",
                        $status->{pod}{age} eq '<invalid>' ? 'x' : $status->{pod}{age},
                    )
                    . ' ';
            }

            $i++;
        }
    }

    $buffer .= "$_RESET_COLORS$_CLEAR_REST_AND_NEWLINE$_RESET_COLORS$_CLEAR_REST";
    $num_lines++;

    return $buffer;
}

sub _render_prefix_compact_horizontal {
    my ($prefix, $max_width) = @_;
    $max_width -= 2;

    my $shortened_prefix = $prefix;
    my $segment_width = $max_width;
    until (length($shortened_prefix) <= $max_width) {
        $segment_width--;
        $shortened_prefix = join '-', map { substr $_, 0, $segment_width } (split '-', $prefix);
    }

    return sprintf("%-${max_width}s ", $shortened_prefix);
}

sub _update_aggregation {
    my ($group_aggregations, $group_header, $status) = @_;

    my $aggregation = $group_aggregations
        ->{$group_header->{header}}{"$status->{pod}{generation}-$status->{pod}{pod_status}"} ||= {
            count => 0,
            pod_status => $status->{pod}{pod_status},
            running_containers => 0,
            total_containers => 0,
            restarts => 0,
            is_updated => 0,
        };

    $aggregation->{count}++;

    my ($running_containers, $total_containers)
        = split qr,\s*/\s*,, $status->{pod}{container_status};
    $aggregation->{running_containers} += $running_containers;
    $aggregation->{total_containers} += $total_containers;

    $aggregation->{restarts} += $status->{pod}{restarts};

    $aggregation->{age} += $status->{pod}{age};

    $aggregation->{is_updated} = 1
        if $status->{pod}{is_updated};

    return;
}
