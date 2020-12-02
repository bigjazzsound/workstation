PAGER=less
LESS='-RIq'
GOPATH="$HOME/.local"
PATH=${HOME}/.local/bin:${PATH}
FZF_DEFAULT_OPTS='--height 40%'
[[ -f $(command -v bat) ]] && BAT_THEME=ansi-dark
