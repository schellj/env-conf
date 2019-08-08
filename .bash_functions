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

function track_container {
    container=$1
    shift
    sources=$@
    files=$(for s in $sources; do git -C $HOME/src/$s ls-files | awk -v d=$HOME -v s=$s '{print d "/src/" s "/" $1}'; done)
    fswatch $files | while read f; do echo [[$f]]; docker restart $container; done
}

function watch_container {
    container=$1
    while sleep 3; do docker_id=$(docker ps -qf name=$container); if [ "x$docker_id" != "x" ]; then docker attach $container; else echo .; fi; done
}

function kube_bounce_deployment {
	deployment=$1

	command=$(echo kubectl patch deployment $deployment -p "'{\"spec\":{\"template\":{\"metadata\":{\"creationTimestamp\":\"`date --utc '+%FT%TZ'`\"}}}}'")
	echo $command
	eval $command
}

function kube_bounce_statefulset {
    statefulset=$1

	command=$(echo kubectl patch statefulset $statefulset -p "'{\"spec\":{\"template\":{\"metadata\":{\"creationTimestamp\":\"`date --utc '+%FT%TZ'`\"}}}}'")
	echo $command
	eval $command
}

function kube_force_delete_pod {
    pod=$1

    delete_command=$(echo kubectl delete pods $pod --force --grace-period=0)
    echo $delete_command
    eval $delete_command

    patch_command=$(kubectl patch pod $pod -p '{"metadata":{"finalizers":null}}')
    echo $patch_command
    eval $patch_command
}
