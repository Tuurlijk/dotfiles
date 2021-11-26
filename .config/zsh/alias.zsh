if [ $(uname) = Darwin ]; then
  alias ls='/usr/local/bin/gls --color=auto'
else
  alias ls='exa'
fi

# Argh
alias sup="sudo pacman -Suy"

# Kitty
# https://gist.github.com/katef/fb4cb6d47decd8052bd0e8d88c03a102
# https://twitter.com/thingskatedid/status/1316074032379248640
alias icat="kitty +kitten icat --align left"
alias kd="kitty +kitten diff"

# nnn iconlookup likes gawk (GNU awk)
alias awk=gawk

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Shortcuts
alias g="git"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gd="git diff"
alias gp="git push"
alias s="git status"
alias h="history"
alias n="nnn -Pp"
alias open="xdg-open"
alias o="xdg-open"

# Vim shortcuts
alias vi=vim
alias v=vim

# Docker
alias d=docker
alias dbd="./.docker/bin/dump.sh"
alias dp="docker ps"
alias dc="docker-compose -f .docker/docker-compose.yml -f .docker/docker-compose.*.yml"
alias dev="docker-compose -f .docker/docker-compose.yml -f .docker/docker-compose.*.yml"
alias down='f(){ dev rm -fsv $@; unset -f f; }; f'
alias up='f(){ dev up -d $@ && dev logs -f before_script after_script; unset -f f; }; f'
alias re='f(){ dev rm -fsv $@ && dev up -d $@ && dev logs -f before_script after_script; unset -f f; }; f'
alias ds="dev exec -u dev php zsh -l"
alias de="dev exec -u dev"
alias dcf='e_header "Running typo3cms cache:flush"; ds -c "./Web/bin/typo3cms cache:flush"; e_success Done'
alias dct='e_header "Clearing ./Web/typo3temp/*"; ds -c "echo removing \`find ./Web/typo3temp/ -type f | wc -l\` files; rm -rf ./Web/typo3temp/*"; e_success Done'
alias dei='e_header "Enabling install tool"; ds -c "touch ./Web/typo3conf/ENABLE_INSTALL_TOOL"; e_success Done'
alias lzd='lazydocker -f ./.docker/docker-compose.yml'

alias l="ls -F"
alias ll="ls -h -l "
alias la="ls -a"
# List only directories and symbolic links that point to directories
alias lsd='ls -ld *(-/DN)'
# List only file beginning with "."
alias lsa='ls -ld .*'
if [[ -f /etc/arch-release ]] || [[ -f /etc/debian_version ]]; then
  alias grep="grep --color=auto"
fi
alias know="vim ${HOME}/.ssh/known_hosts"
alias mc="mc --nosubshell"
alias reload!=". ${HOME}/.zshrc"
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done
