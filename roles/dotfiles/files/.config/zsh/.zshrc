# Iterate over zsh config files
if [[ -d "${ZDOTDIR:-$HOME}"/zsh.d ]]; then
    for ZSH_FILE in $(ls -A "${ZDOTDIR:-$HOME}"/zsh.d/*.zsh); do
        source "${ZSH_FILE}"
    done
fi

# Add any local overrides
[[ -f "${ZDOTDIR}"/.zshrc.local ]] && source "${ZDOTDIR}"/.zshrc.local
