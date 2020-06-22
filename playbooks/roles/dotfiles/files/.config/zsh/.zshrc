# exported dirs
export documents="$HOME/Documents"
export plays="$HOME/playground/workstation"
bindkey -e

setopt HIST_IGNORE_DUPS
setopt autocd

# exported variables
export PAGER=less
export LESS='-RIq'
export GOPATH="$HOME/.local"
export PATH=${HOME}/.local/bin:${PATH}
export FZF_DEFAULT_OPTS='--height 40%'
if [[ -f $(command -v bat) ]]; then
    export BAT_THEME=ansi-dark
    export MANPAGER="sh -c 'col -bx | bat -l man'"
fi
[[ -f $(command -v fd) ]] && export FZF_DEFAULT_COMMAND='fd -H --type f'

# aliases
alias dirs='dirs -l -v'
alias ip='ip -c'
if [[ -f $(command -v xsel) ]]; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi
alias A='sudo apt update && sudo apt upgrade -y'
alias Y='sudo yum upgrade -y'
alias pwm='ANSIBLE_CONFIG=$plays/ansible.cfg ansible-playbook $plays/playbooks/main.yml'
alias sz="source $HOME/.config/zsh/.zshrc"
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
[[ -f $(command -v exa) ]] && alias ls='exa' ll='exa -l' tree='exa -T'
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

# mutt
[[ -f $(command -v neomutt) ]] && alias m='neomutt' mutt='neomutt'

# Edit long command in nvim window
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

### Added by Zinit's installer
declare -A ZINIT
ZINIT[HOME_DIR]=$ZDOTDIR/zinit
if [[ ! -f $ZDOTDIR/zinit/bin/zinit.zsh ]]; then
    print -P "Installing DHARMA Initiative Plugin Manager (zdharma/zinit)"
    command git clone https://github.com/zdharma/zinit "$ZDOTDIR/zinit/bin" && \
        print -P "Installation successful." || print -P "The clone has failed."
fi
source "$ZDOTDIR/zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

if [[ "$(uname)" == "Linux" ]]; then
	zinit ice from"gh-r" as"command" bpick"*linux*" mv"exa* -> exa"; zinit load ogham/exa
	zinit ice from"gh-r" as"command" bpick"dust-v*-x86_64-unknown-linux-gnu.tar.gz" pick"dust*/dust"; zinit load bootandy/dust
	zinit ice from"gh-r" as"command" bpick"fd-*-x86_64-unknown-linux-gnu.tar.gz" pick"fd*/fd"; zinit load sharkdp/fd
	zinit ice from"gh-r" as"command" bpick"ripgrep-*linux-*" pick"ripgrep*/rg"; zinit load BurntSushi/ripgrep
	zinit ice from"gh-r" as"command" bpick"starship-x86_64-unknown-linux-gnu*"; zinit load starship/starship
    zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
    zinit ice from"gh-r" as"command"; zinit load junegunn/fzf-bin
fi
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/completion.zsh"
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"
zinit ice as"completion"; zinit snippet "https://github.com/docker/cli/tree/master/contrib/completion/zsh/_docker"
zinit snippet OMZ::lib/history.zsh
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zdharma/zsh-diff-so-fancy
# zinit snippet "https://github.com/lincheney/fzf-tab-completion/blob/master/zsh/fzf-zsh-completion.sh"
zinit light zsh-users/zsh-autosuggestions
bindkey '^n' autosuggest-accept
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=14,bold,underline"

autoload compinit; compinit
# AWS completion is not working with plugins, so just manually load with source
source $(which aws_zsh_completer.sh)

# Swap the case of letters in completion
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Enable partial completion
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

eval "$(starship init zsh)"

# Add any local overrides
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
