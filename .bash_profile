[[ -s ~/.bashrc ]] && source ~/.bashrc
export PATH="~/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
export PATH="/usr/local/opt/unzip/bin:$PATH"
export PATH="~/bin/Sencha/Cmd:~/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$GOPATH/bin:$PATH"

##
# Your previous /Users/jschell/.bash_profile file was backed up as /Users/jschell/.bash_profile.macports-saved_2019-12-07_at_16:37:43
##

# MacPorts Installer addition on 2019-12-07_at_16:37:43: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="/usr/local/opt/helm@2/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export DBR_PRISTINE="/Users/jschell/gtperl/test-db-pristine"
export DBR_SANDBOX="/Users/jschell/gtperl/test-db-sandbox"
export DBR_CONF_FILE="$DBR_SANDBOX/DBR.conf"
