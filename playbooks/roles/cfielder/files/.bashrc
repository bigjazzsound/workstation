## GENERAL OPTIONS ##
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

[[ -f ~/.local/bin/sensible.bash ]] || wget -q -O ~/.local/bin/sensible.bash https://raw.githubusercontent.com/mrzool/bash-sensible/master/sensible.bash
source ~/.local/bin/sensible.bash

# exported dirs
export documents="$HOME/Documents"
export plays="$HOME/playground/workstation"

# exported variables
export PAGER=less
export LESS='-RIq'
export PS1="\[\033[1;36m\]\\u@\h \$ \[$(tput sgr0)\]"
export GOPATH="$HOME/.local/go"
if [[ $(command -v go) ]]; then
    export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/go/bin
else
    export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin
fi
export FZF_DEFAULT_OPTS='--height 40%'
if [[ -f $(command -v fd) ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f'
fi

# aliases
alias dirs='dirs -l -v'
alias ip='ip -c'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias A='sudo apt update && sudo apt upgrade -y'
alias Y='sudo yum upgrade -y'
alias pwm='ANSIBLE_CONFIG=$plays/ansible.cfg ansible-playbook $plays/playbooks/main.yml'
alias sb="source ~/.bashrc"
alias vs='vim -c "set spell" /tmp/$(openssl rand -hex 6).md'
alias vsg='vim -c Goyo -c "set spell" /tmp/$(openssl rand -hex 6).md'
alias vj="vim /tmp/$(openssl rand -hex 6).json"
alias vy="vim /tmp/$(openssl rand -hex 6).yml"
alias news="newsbeuter"
alias tf="terraform "
alias tff="terraform fmt "

# neovim all the things, if installed
if [[ -f $(command -v nvim) ]]; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d '
    export EDITOR=nvim VISUAL=nvim
else
    export EDITOR=vim VISUAL=vim
fi

if [[ -f $(command -v exa) ]]; then
    alias ls='exa'
    alias ll='exa -l'
    alias tree='exa -T'
else
    alias ls='ls --color'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

if [[ -f $(command -v neomutt) ]]; then
    alias m='neomutt'
    alias mutt='neomutt'
fi

[[ -f ~/.config/dircolors/dircolors.256dark ]] || wget -q -O ~/.config/dircolors/dircolors.256dark https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
eval $(dircolors ~/.config/dircolors/dircolors.256dark)

if [[ ! -d ~/.fzf ]]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --key-bindings --completion --no-update-rc
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# completions
complete -C "$HOME/.local/bin/aws_completer" aws
complete -C $(which vault) vault
complete -C $(which consul) consul
command -v kubectl >/dev/null && source <(kubectl completion bash)

# Local bashrc file for per-host changes
[ -f ~/.bashrc.local ] && source ~/.bashrc.local