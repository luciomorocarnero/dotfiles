# Setup fzf
# ---------
if [[ ! "$PATH" == */home/lucio/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/lucio/.fzf/bin"
fi

eval "$(fzf --bash)"
