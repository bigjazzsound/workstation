bindkey -e
setopt autocd

# Edit long command in nvim window
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
