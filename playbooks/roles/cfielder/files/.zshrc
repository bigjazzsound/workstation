# exported dirs
export documents="$HOME/Documents"
export plays="$HOME/playground/workstation"
bindkey -e

# exported variables
export PAGER=less
export LESS='-RIq'
export GOPATH="$HOME/.local"
export PATH=$PATH:$HOME/.local/bin
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
alias sz="source ~/.zshrc"
alias vs='vim -c "set spell" /tmp/$(openssl rand -hex 6).md'
alias vsg='vim -c Goyo -c "set spell" /tmp/$(openssl rand -hex 6).md'
alias vj="vim /tmp/$(openssl rand -hex 6).json"
alias vy="vim /tmp/$(openssl rand -hex 6).yml"
alias vg="vim +Gstatus +only"
alias news="newsbeuter"
alias tf="terraform "
alias tff="terraform fmt "
alias tfa="terraform apply "
alias tfp="terraform plan "
alias colors="curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash"
alias ls='exa'
alias ll='exa -l'
alias tree='exa -T'
alias ccd="cd "
alias ..="cd .."

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

if [[ -f $(command -v neomutt) ]]; then
    alias m='neomutt'
    alias mutt='neomutt'
fi

# Edit long command in nvim window
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

#
if [[ "$(uname)" == "Linux" ]]; then
	zinit ice from"gh-r" as"command" bpick"*linux*" mv"exa* -> exa"; zinit load ogham/exa
	zinit ice from"gh-r" as"command" bpick"dust-v*-x86_64-unknown-linux-gnu.tar.gz" pick"dust*/dust"; zinit load bootandy/dust
	zinit ice from"gh-r" as"command" bpick"fd-*-x86_64-unknown-linux-gnu.tar.gz" pick"fd*/fd"; zinit load sharkdp/fd
	zinit ice from"gh-r" as"command" bpick"ripgrep-*linux-*" pick"ripgrep*/rg"; zinit load BurntSushi/ripgrep
	zinit ice from"gh-r" as"command" bpick"starship-x86_64-unknown-linux-gnu*"; zinit load starship/starship
fi
# FZF
zinit ice from"gh-r" as"command"; zinit load junegunn/fzf-bin
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/completion.zsh"
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"
zinit snippet "https://github.com/mhartington/oceanic-next-shell/blob/master/oceanic-next.dark.sh"
zinit ice as"completion"; zinit snippet "https://github.com/docker/cli/tree/master/contrib/completion/zsh/_docker"
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zdharma/zsh-diff-so-fancy
# zinit snippet "https://github.com/lincheney/fzf-tab-completion/blob/master/zsh/fzf-zsh-completion.sh"
zinit light zsh-users/zsh-autosuggestions
bindkey '^n' autosuggest-accept

autoload compinit; compinit
# AWS completion is not working with plugins, so just manually load with source
source $(which aws_zsh_completer.sh)

# Swap the case of letters in completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Enable partial completion
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

eval "$(starship init zsh)"

# Get any local overrides
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
