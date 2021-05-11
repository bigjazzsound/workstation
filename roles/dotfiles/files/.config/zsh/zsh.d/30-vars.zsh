PAGER=less
LESS='-RIq'
GOPATH="$HOME/.local"
PATH=${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}
FZF_DEFAULT_OPTS='--height 40%'
[[ -f $(command -v bat) ]] && BAT_THEME=OneHalfDark

setopt histfcntllock histignorealldups histsavenodups sharehistory
SAVEHIST=$(( 100 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST ))  # zsh recommended value

XDG_CONFIG_HOME="${HOME}"/.config
XDG_DATA_HOME="${HOME}"/.local/share

HISTFILE="${XDG_DATA_HOME}"/zsh_history
