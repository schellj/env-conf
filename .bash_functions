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
