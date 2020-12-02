[[ -f $(command -v starship) ]] || \
    $(curl -fsSL https://starship.rs/install.sh | bash -s -- --bin-dir $HOME/.local/bin --yes)
eval "$(starship init zsh)"
