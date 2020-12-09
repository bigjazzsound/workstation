if [[ "$(uname)" == "Linux" ]] && [[ ! -x $(command -v starship) ]]; then
    curl -fsSL https://starship.rs/install.sh | bash -s -- --bin-dir $HOME/.local/bin --yes
fi

eval "$(starship init zsh)"
