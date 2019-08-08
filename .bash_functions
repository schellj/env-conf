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
