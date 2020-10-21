# exported dirs
DOCUMENTS="$HOME/Documents"
PLAYS="$HOME/playground/workstation"
bindkey -e

setopt autocd

# exported variables
PAGER=less
LESS='-RIq'
GOPATH="$HOME/.local"
PATH=${HOME}/.local/bin:${PATH}
FZF_DEFAULT_OPTS='--height 40%'
if [[ -f $(command -v bat) ]]; then
    BAT_THEME=ansi-dark
    PAGER=bat
fi

# aliases
alias dirs='dirs -l -v'
alias ip='ip -c'
alias A='sudo apt update && sudo apt upgrade -y'
alias Y='sudo yum upgrade -y'
alias pwm='ANSIBLE_CONFIG=${PLAYS}/ansible.cfg ansible-playbook ${PLAYS}/playbooks/main.yml'
alias vs='vim -c "set spell" /tmp/$(openssl rand -hex 6).md'
alias vsg='vim -c Goyo -c "set spell" /tmp/$(openssl rand -hex 6).md'
alias vj="vim /tmp/$(openssl rand -hex 6).json"
alias vy="vim /tmp/$(openssl rand -hex 6).yml"
alias vg="vim +Gstatus +only"
alias vz="vim $ZDOTDIR/.zshrc*"
alias sz="source $ZDOTDIR/.zshrc"
alias news="newsbeuter"
if [[ -f $(command -v terraform) ]]; then
    alias tf="terraform "
    alias tff="terraform fmt "
    alias tfa="terraform apply "
    alias tfp="terraform plan "
fi
alias colors="curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash"
alias ccd="cd "
alias ..="cd .."

# neovim all the things, if installed
if [[ -f $(command -v nvim) ]]; then
    alias v='nvim' vi='nvim' vim='nvim' vimdiff='nvim -d '
    EDITOR=nvim VISUAL=nvim MANPAGER='nvim +Man!'
else
    alias v='vim'
    EDITOR=vim VISUAL=vim
fi

FILETYPES=(c cfg conf csv go h html ini j2 json lua md php ps1 py sh tf tfvars tmpl txt vim xml yaml yml)
for FILETYPE in ${FILETYPES}; do alias -s $FILETYPE="vim "; done

# Edit long command in nvim window
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Setup starship prompt
[[ -f $(command -v starship) ]] || \
    $(curl -fsSL https://starship.rs/install.sh | bash -s -- --bin-dir $HOME/.local/bin --yes)
eval "$(starship init zsh)"

# PLUGINS
ZPLUGINDIR=$HOME/.zsh
if [[ ! -d  $ZPLUGINDIR ]]; then
    mkdir $ZPLUGINDIR
    [[ -f $(command -v git) ]] && \
        git clone https://github.com/marlonrichert/zsh-snap.git $ZPLUGINDIR/zsh-snap
fi
source $ZPLUGINDIR/zsh-snap/znap.zsh

PLUGINS=(
    "Aloxaf/fzf-tab"
    "MichaelAquilina/zsh-auto-notify"
    "ohmyzsh/ohmyzsh"
    "zdharma/fast-syntax-highlighting"
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-completions"
    "zpm-zsh/clipboard"
    "DarrinTisdale/zsh-aliases-exa"
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
znap source fzf-tab
znap source ${OMZ} "lib/history.zsh"
znap source fast-syntax-highlighting
znap source zsh-completions
znap source zsh-autosuggestions
znap source clipboard
znap source zsh-aliases-exa
bindkey '^n' autosuggest-accept
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=14,bold,underline"

autoload -Uz compinit; compinit -i
# AWS completion is not working with plugins, so just manually load with source
source $(which aws_zsh_completer.sh)

# Swap the case of letters in completion
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Enable partial completion
zstyle ':completion:*' list-suffixes expand prefix suffix

# Add any local overrides
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
