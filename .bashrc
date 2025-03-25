#
# ~/.bashrc
#

export PATH="~/.local/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# golang
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$PATH

alias locker='~/.config/hypr/scripts/lock_screen.sh'
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT1"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

TERM="tmux-256color"
alias ls='ls --color=auto'
alias grep='rg --color=auto'
alias cat="bat"

# Zoxide
alias cd="z"
eval "$(zoxide init bash)"

# Disable tmux when sshing 

function ssh() {
	#    if [ -n "${TMUX}" ]; then
	# tmux set status off
	# tmux set prefix None
	#    fi

    # https://unix.stackexchange.com/questions/454553/bash-shadow-a-command-function-with-same-name-as-command
    command ssh "$@"

	#    if [ -n "${TMUX}" ]; then
	# tmux set status on
	# tmux set prefix C-s
	#    fi
}

function nmtui() {
    nmcli device wifi rescan
    c="$COLORTERM"
    unset COLORTERM
    TERM=xterm-old command nmtui
    set COLORTERM "$c"
}

PS1='[\u@\h \W]\$ '

# https://wiki.archlinux.org/title/Tmux#Start_tmux_on_every_shell_login
#
# Start tmux on every shell login

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion




