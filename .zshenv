#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

. "$HOME/.cargo/env"

# Begin added by argcomplete
fpath=( /usr/lib/python3.13/site-packages/argcomplete/bash_completion.d "${fpath[@]}" )
# End added by argcomplete
