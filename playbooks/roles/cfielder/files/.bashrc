## GENERAL OPTIONS ##
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2>/dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
# PROMPT_COMMAND='history -a'
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT="%d/%m/%y %T "

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2>/dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2>/dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2>/dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

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

command -v kubectl >/dev/null && source <(kubectl completion bash)

[[ -f ~/.config/dircolors/dircolors.256dark ]] && eval $(dircolors ~/.config/dircolors/dircolors.256dark)

# AWS CLI bash completion
complete -C "$HOME/.local/bin/aws_completer" aws
complete -C $(which vault) vault
complete -C $(which consul) consul

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
