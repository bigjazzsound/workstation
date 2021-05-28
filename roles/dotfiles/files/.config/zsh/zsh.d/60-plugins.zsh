ZPLUGINDIR="${HOME}/.zsh"
if [[ ! -d  "${ZPLUGINDIR}" ]]; then
    mkdir "${ZPLUGINDIR}"
    [[ -f $(command -v git) ]] && \
        git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git "${ZPLUGINDIR}/zsh-snap"
fi

# source $ZPLUGINDIR/zsh-snap/znap.zsh

znap source marlonrichert/zcolors
znap eval zcolors "zcolors ${(q)LS_COLORS}"

znap source ohmyzsh/ohmyzsh plugins/ansible
znap source ohmyzsh/ohmyzsh plugins/asdf
znap source ohmyzsh/ohmyzsh plugins/aws
znap source ohmyzsh/ohmyzsh plugins/docker

znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=14,bold,underline"
ZSH_AUTOSUGGEST_USE_ASYNC="true"
bindkey '^n' autosuggest-accept

# TODO - not sure if I want to use this plugin yet or not
zstyle ':autocomplete:tab:*' fzf-completion yes
zstyle ':autocomplete:*' min-input 2
zstyle ':completion:*:' group-order \
    commands
zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands
zstyle ':autocomplete:*' widget-style menu-select
znap source marlonrichert/zsh-autocomplete

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
znap source zsh-users/zsh-syntax-highlighting

znap source zpm-zsh/clipboard
znap source zsh-users/zsh-completions
znap source blimmer/zsh-aws-vault
znap source ogham/exa
fpath=($fpath ~[exa]/completions/zsh)
znap source sharkdp/fd
fpath=($fpath ~[fd]/contrib/completion)

if [[ -f $(command -v notify-send) ]]; then
    znap source MichaelAquilina/zsh-auto-notify
    AUTO_NOTIFY_IGNORE+=("nvim", "git", "mpv")
    AUTO_NOTIFY_THRESHOLD=30
fi

znap compdef _rustup 'rustup completions zsh'
znap compdef _cargo 'rustup completions zsh cargo'

if [[ -f $(command -v fzf) ]]; then
    FZF_DEFAULT_OPTS='--height=60% --layout=reverse --multi'
    if [[ -f $(command -v fd) ]]; then
        FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git venv'
        FZF_CTRL_T_COMMAND='fd --type f --follow --exclude .git'
        FZF_CTRL_T_OPTS='--multi --preview="bat --line-range :50 --color=always --style plain {}"'
    fi
    znap source ohmyzsh/ohmyzsh plugins/fzf
    # znap source Aloxaf/fzf-tab
fi
