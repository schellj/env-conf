#function emacs {
#   open -a emacs --args $@ 2>&1 1>/dev/null &
#}

function grep_shortcut {
    local x=$1
    shift
    local y=$@
    eval "x=($x)"
    shift 2
    egrep -Irs --exclude '*~' --exclude '*.gz' --exclude '*/.git/*' --exclude '*/archive/*' --exclude '*/architect/*' --exclude '*/sdk/*' --exclude '*/build/*' "${x[@]}" "${y[@]}" . 2>/dev/null
}

function g {
    grep_shortcut "" $@
}

function gi {
    grep_shortcut "-i" $@
}

function gpm {
    grep_shortcut "--include '*.pm'" $@
}

function gpmi {
    grep_shortcut "-i --include '*.pm'" $@
}

function gjs {
    grep_shortcut "--include '*.*js'" $@
}

function gjsi {
    grep_shortcut "-i --include '*.*js'" $@
}

function reth {
    sudo ifdown eth0 && sudo ifup eth0
}

function gg {
    git grep $@
}

function title {
    echo -ne "\033]0;"$*"\007"
}

function old_nodes {
    old_nodes="$(echo $(gcloud compute instance-groups managed list-instances auto1-$1 | grep -v NAME | awk '{print $1}'))"
    echo old_nodes: $old_nodes
}

function abandon_nodes {
    group=$1
    shift
    nodes=$@
    echo gcloud compute instance-groups managed abandon-instances auto1-$group --instances="$(echo $nodes | tr ' ' ',')"
    gcloud compute instance-groups managed abandon-instances auto1-$group --instances="$(echo $nodes | tr ' ' ',')"
}

function node_status {
    group=$1
    shift
    command=$@
    if [ "x$command" = "x" ]
    then
        command='sudo docker ps -a';
    fi

    echo for z in \$\( gcloud compute instance-groups managed list-instances auto1-$group --uri \)\; do echo \$z\; gcloud compute ssh \$z -- \"$command\"\; done
    for z in $( gcloud compute instance-groups managed list-instances auto1-$group --uri ); do echo $z; gcloud compute ssh $z -- $command; done
}

function delete_nodes {
    echo gcloud compute instances delete $@
    gcloud compute instances delete $@
}

