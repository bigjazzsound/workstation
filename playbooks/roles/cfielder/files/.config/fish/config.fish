# aliases
alias dirs='dirs -l -v'
alias ip='ip -c'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias A='sudo apt update && sudo apt upgrade -y'
alias Y='sudo yum upgrade -y'
alias pwm='ANSIBLE_CONFIG=$plays/ansible.cfg ansible-playbook $plays/playbooks/main.yml'
alias sb="source ~/.bashrc"
alias vs='vim /tmp/(openssl rand -hex 6).md'
alias vsg='vim -c Goyo -c "set spell" /tmp/(openssl rand -hex 6).md'
alias vj="vim /tmp/(openssl rand -hex 6).json"
alias vy="vim /tmp/(openssl rand -hex 6).yml"
alias vg="vim +Gstatus +only"
alias news="newsbeuter"
alias tf="terraform "
alias tff="terraform fmt "
alias tfa="terraform apply "
alias tfp="terraform plan "
alias colors="curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash"
alias ccd="cd "
alias ..="cd .."

# exported variables
set -x GOPATH "$HOME/.local"
set -x AWS_PROFILE prod
set -x PAGER less
set -x LESS '-RIq'
set -x FZF_DEFAULT_OPTS '--height 40%'
if test (command -v fd)
    set -x FZF_DEFAULT_COMMAND 'fd --type f'
end

if test (command -v exa)
    alias ls='exa'
    alias ll='exa -l'
    alias tree='exa -T'
else
    alias ls='ls --color'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
end

if test (command -v nvim)
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d '
    set -x EDITOR nvim
    set -x VISUAL nvim
else
    set -x EDITOR vim
    set -x VISUAL vim
end

function fish_prompt
    $GOPATH/bin/powerline-go -error $status -shell bare -modules 'nix-shell,user,host,ssh,perms,jobs,dotenv,git,aws,terraform-workspace,venv,kube'
end

set PATH ~/.local/bin ~/.cargo/bin $PATH

if test -e ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
