emulate sh -c 'source ~/.profile'
eval "$(zoxide init zsh)"
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)

source $ZSH/oh-my-zsh.sh

autoload -Uz vcs_info

GIT_COLOR="#4f754f"
GIT_COLOR_DIM=`~/.dotfiles/dim $GIT_COLOR 0.4`
FS_COLOR="#4a558c"
FS_COLOR_DIM=`~/.dotfiles/dim $FS_COLOR 0.4`

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "\
%F{$GIT_COLOR}%K{$GIT_COLOR}%F{$GIT_COLOR_DIM}%F{$GIT_COLOR}%K{$GIT_COLOR_DIM}%K{$GIT_COLOR_DIM} %f%b%k%F{$GIT_COLOR_DIM}%f%k "

setopt PROMPT_SUBST
PROMPT=' %F{$FS_COLOR}%K{$FS_COLOR}%F{$FS_COLOR_DIM}%F{$FS_COLOR}%K{$FS_COLOR_DIM}%K{$FS_COLOR_DIM} %f%~%k%F{$FS_COLOR_DIM}%f%k ${vcs_info_msg_0_}'

precmd() { vcs_info }
