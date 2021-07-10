fish_add_path $HOME/.local/bin $HOME/.cargo/bin /opt/homebrew/bin /opt/homebrew/opt/llvm/bin

type -q fisher || curl -sL https://git.io/fisher | source

function fpkgs
    fisher install \
        jorgebucaran/fisher \
        jethrokuan/fzf
end

set FZF_COMPLETE 2

command -qv starship; and starship init fish | source

bind \cn accept-autosuggestion

set FZF_DEFAULT_OPTS '--height=40% --layout=reverse --multi --border=sharp --preview-window=:sharp:'
if command -qv fd
    set FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git venv'
    set FZF_CTRL_T_COMMAND 'fd --type f --follow --exclude .git'
    set FZF_CTRL_T_OPTS '--multi --preview="bat --line-range :50 --color=always --style plain {}"'
end

set DOCUMENTS "$HOME/Documents"
set PLAYS "$HOME/playground/workstation"

alias pwm 'ANSIBLE_CONFIG=$PLAYS/ansible.cfg $PLAYS/venv/bin/ansible-playbook $PLAYS/playbooks/main.yml'
alias vs 'vim -c "set spell" /tmp/(openssl rand -hex 6).md'
alias vj "vim /tmp/(openssl rand -hex 6).json"
alias vy "vim /tmp/(openssl rand -hex 6).yml"
alias vg "vim +Gstatus +only"
if command -qv terraform
    alias tf "terraform "
    alias tff "terraform fmt "
    alias tfa "terraform apply "
    alias tfp "terraform plan "
end
alias ccd "cd "
alias .. "cd .."

if command -qv exa
    alias ls "exa"
    alias ll "exa -l"
    alias la "exa -la"
end

if command -qv nvim
    alias v 'nvim'
    alias vi 'nvim'
    alias vim 'nvim'
    alias vimdiff 'nvim -d '
    set EDITOR nvim
    set VISUAL nvim
else
    set EDITOR vim
    set VISUAL vim
end

if test -e ~/.asdf/asdf.fish
    . ~/.asdf/asdf.fish
end

command -qv aws; and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

set fish_greeting

if test -e ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
