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
if [[ -f $(command -v terraform) ]]; then
    alias tf="terraform "
    alias tff="terraform fmt "
    alias tfa="terraform apply "
    alias tfp="terraform plan "
fi
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

FILETYPES=(c cfg conf csv go h html ini j2 json lua md php ps1 py tf tfvars tmpl txt vim xml yaml yml)
for FILETYPE in ${FILETYPES}; do alias -s $FILETYPE="vim "; done

if [[ -f $(command -v zoxide) ]]; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi
