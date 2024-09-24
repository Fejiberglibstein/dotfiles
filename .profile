#
# ~/.bashrc
#

export PATH="$HOME/.local/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# golang
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$PATH

alias locker='~/.config/hypr/scripts/lock_screen.sh'
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT1"
alias tm="tmux a || tmux"

alias ls='ls --color=auto'
alias grep='rg --color=auto'
alias cat="bat"
# Zoxide
alias cd="z"

function nmtui () {
    nmcli device wifi rescan
    c="$COLORTERM"
    unset COLORTERM
    TERM=xterm-old command nmtui
    set COLORTERM "$c"
}

# Disable tmux when sshing 
function ssh () {
    if [ -n "${TMUX}" ]; then
	tmux set status off
	tmux set prefix None
    fi

    # https://unix.stackexchange.com/questions/454553/bash-shadow-a-command-function-with-same-name-as-command
    command ssh "$@"

    if [ -n "${TMUX}" ]; then
	tmux set status on
	tmux set prefix C-s
    fi
}


# TERM="tmux-256color"

