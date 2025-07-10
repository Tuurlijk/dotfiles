# Uncomment to profile zsh startup
#zmodload zsh/zprof

# Set umask
umask g-w,o-rwx

# If command is a path, cd into it
setopt auto_cd

# Colorful messages
e_header() { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error() { echo -e " \033[1;31m✖\033[0m  $@"; }

# Croptesting
#source ${ZDOTDIR:-${HOME}}/.config/zsh/archive/frameworks.zsh

# Show path in title
precmd() {print -Pn "\e]0;${PWD/$HOME/\~}\a"}

# Load zgenom only if a user types a zgenom command
zgenom() {
  if [[ ! -s ${ZDOTDIR:-${HOME}}/.zgenom/zgenom.zsh ]]; then
    git clone https://github.com/jandamm/zgenom.git "${ZDOTDIR:-${HOME}}/.zgenom"
  fi
  # load zgenom
  source "${ZDOTDIR:-${HOME}}/.zgenom/zgenom.zsh"
  zgenom "$@"
}

# Generate zgenom init script if needed
if [[ ! -s ${ZDOTDIR:-${HOME}}/.zgenom/sources/init.zsh ]]; then
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zdharma-continuum/fast-syntax-highlighting
  zgenom load zsh-users/zsh-history-substring-search
  zgenom ohmyzsh plugins/shrink-path
  zgenom ohmyzsh plugins/ssh-agent
  zgenom ohmyzsh --completion plugins/docker-compose
  # generate the init script from plugins above
  zgenom save
fi

# This needs to be loaded before ssh-agent plugin
zstyle :omz:plugins:ssh-agent lazy yes

# Load dircolors
if [ -s ${ZDOTDIR:-${HOME}}/.dircolors ]; then
  eval $(command dircolors -b ${ZDOTDIR:-${HOME}}/.dircolors)
fi

# Load complete compiled settings file including zgenom init
if [[ ! -s ${ZDOTDIR:-${HOME}}/.config/zsh/cache/settings.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.config/zsh/0_functions.zsh
  recreateCachedSettingsFile
fi
source ${ZDOTDIR:-${HOME}}/.config/zsh/cache/settings.zsh

eval $(zoxide init --cmd j zsh)

# Load customized prompt
fpath=(/${ZDOTDIR:-${HOME}}/.config/zsh/functions $fpath)
autoload -Uz promptinit && promptinit
prompt tuurlijk

# Remove whitespace after the RPROMPT
#ZLE_RPROMPT_INDENT=0

# Uncomment to profile zsh startup
#zprof

export NVM_DIR="${ZDOTDIR:-${HOME}}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="${ZDOTDIR:-${HOME}}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
