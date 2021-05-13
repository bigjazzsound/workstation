ZPLUGINDIR=$HOME/.zsh
if [[ ! -d  $ZPLUGINDIR ]]; then
    mkdir $ZPLUGINDIR
    [[ -f $(command -v git) ]] && \
        git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $ZPLUGINDIR/zsh-snap
fi

source $ZPLUGINDIR/zsh-snap/znap.zsh

znap source marlonrichert/zcolors
znap eval zcolors "zcolors ${(q)LS_COLORS}"

# znap source Aloxaf/fzf-tab
znap source ohmyzsh/ohmyzsh plugins/fzf
FZF_DEFAULT_OPTS='--height=60% --layout=reverse --multi'
if [[ -f $(command -v fd) ]]; then
    FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git venv'
    FZF_CTRL_T_COMMAND='fd --type f --follow --exclude .git'
    FZF_CTRL_T_OPTS='--multi --preview="bat --line-range :50 --color=always --style plain {}"'
fi

znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=14,bold,underline"
bindkey '^n' autosuggest-accept

znap source zpm-zsh/clipboard

# TODO - not sure if I wan to use this plugin yet or not
# zstyle ':autocomplete:tab:*' widget-style menu-select
# zstyle ':autocomplete:tab:*' fzf-completion yes
# znap source marlonrichert/zsh-autocomplete
# zstyle ':autocomplete:*' default-context ''
# znap source zsh-users/zsh-completions

znap source DarrinTisdale/zsh-aliases-exa
znap source blimmer/zsh-aws-vault

znap source MichaelAquilina/zsh-auto-notify
AUTO_NOTIFY_IGNORE+=("nvim", "git", "mpv")
AUTO_NOTIFY_THRESHOLD=30
