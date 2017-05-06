# Set rbenv root
export RBENV_ROOT="/usr/local/rbenv"

# Append rbenv to end of PATH
export PATH="${PATH}:${RBENV_ROOT}/bin"

# Load rbenv
eval "$(rbenv init -)"
