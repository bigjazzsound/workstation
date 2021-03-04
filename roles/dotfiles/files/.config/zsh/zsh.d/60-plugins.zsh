ZPLUGINDIR=$HOME/.zsh
if [[ ! -d  $ZPLUGINDIR ]]; then
    mkdir $ZPLUGINDIR
    [[ -f $(command -v git) ]] && \
        git clone https://github.com/marlonrichert/zsh-snap.git $ZPLUGINDIR/zsh-snap
fi
source $ZPLUGINDIR/zsh-snap/znap.zsh

PLUGINS=(
    "Aloxaf/fzf-tab"
    "DarrinTisdale/zsh-aliases-exa"
    "MichaelAquilina/zsh-auto-notify"
    "blimmer/zsh-aws-vault"
    "ohmyzsh/ohmyzsh"
    "zdharma/fast-syntax-highlighting"
    "zpm-zsh/clipboard"
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-completions"
)

for PLUGIN in ${PLUGINS}; do
    if [[ ! -d ${ZPLUGINDIR}/$(basename ${PLUGIN}) ]]; then
        ZPLUGINS+=($(echo "https://github.com/${PLUGIN}.git"))
    fi
done; [[ -n ${ZPLUGINS} ]] && znap clone $(echo ${ZPLUGINS} | xargs)

OMZ="ohmyzsh"
znap source ${OMZ}
znap source ${OMZ} \
    plugins/ansible \
    plugins/fzf
FZF_DEFAULT_OPTS='--height=60% --layout=reverse --multi'
if [[ -f $(command -v fd) ]]; then
    FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git venv'
    FZF_CTRL_T_COMMAND='fd --type f --follow --exclude .git'
    FZF_CTRL_T_OPTS='--multi --preview="bat --line-range :50 --color=always --style plain {}"'
fi
znap source zsh-aws-vault
znap source fzf-tab
znap source ${OMZ} "lib/history.zsh"
znap source fast-syntax-highlighting
znap source zsh-completions
znap source zsh-autosuggestions
znap source clipboard
znap source zsh-aliases-exa
bindkey '^n' autosuggest-accept
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=14,bold,underline"

# Prevent OMZ from auto-updating
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
