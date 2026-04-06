# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export EDITOR=nvim

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZOXIDE_CMD_OVERRIDE="cd"
ENABLE_CORRECTION="true"
# CASE_SENSITIVE="true"

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# command auto-correction.
ENABLE_CORRECTION="true"

plugins=(
    zsh-syntax-highlighting
    zoxide
    fzf
    zsh-autosuggestions
    tmux
)

source $ZSH/oh-my-zsh.sh

#====== Aliases ======
alias ls='exa -al -F -s=type --group-directories-first --icons --color=always'
alias lt="exa -al -T -L"
ld() {
    local depth=1
    local copy=false
    local args=()

    for arg in "$@"; do
        if [[ "$arg" == "-c" ]]; then
            copy=true
        elif [[ "$arg" =~ ^[0-9]+$ ]]; then
            depth=$arg
        else
            args+=("$arg")
        fi
    done

    if [ "$copy" = true ]; then
        fd -H . -d "$depth" "${args[@]}" | wl-copy
    else
        fd -H . -d "$depth" "${args[@]}"
    fi
}
alias python='python3'
alias vim='nvim'
alias gitclone="git clone --depth=1"
alias c="clear"
alias mount-ubuntu='sudo mount /dev/nvme0n1p4 /mnt/ubuntu'
alias Ss="pacman -Ss"
alias Qs="pacman -Qs"
alias S="sudo pacman -S"

# Yazi file manager with directory changing
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"

    if [ -f "$tmp" ]; then
        local cwd
        IFS= read -r cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd -- "$cwd"
    fi

    rm -f -- "$tmp"
}

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export TERM='xterm'
else
    export TERM='xterm-kitty'
fi

# ZOXIDE
eval "$(zoxide init zsh)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# NAVI
eval "$(navi widget zsh)"

# POWERLEVEL10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
