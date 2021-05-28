# autoload -Uz compinit; compinit -i
# AWS completion is not working with plugins, so just manually load with source
# source $(which aws_zsh_completer.sh)

# Swap the case of letters in completion
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Enable partial completion
zstyle ':completion:*' list-suffixes expand prefix suffix
