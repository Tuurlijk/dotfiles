if [ $(uname) = Darwin ]; then
  alias ls='/usr/local/bin/gls --color=auto'
elif type exa > /dev/null; then
  alias ls='exa --group-directories-first'
fi

# Kitty
# https://gist.github.com/katef/fb4cb6d47decd8052bd0e8d88c03a102
# https://twitter.com/thingskatedid/status/1316074032379248640
alias icat="kitty +kitten icat --align left"
alias kd="kitty +kitten diff"

# nnn iconlookup likes gawk (GNU awk)
alias awk=gawk

alias bat=batcat

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias z="zoxide"

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
alias dbd="./.docker/bin/dump.sh"
alias dp="docker ps"
alias down='f(){ d rm -fsv $@; unset -f f; }; f'
alias up='f(){ d up -d $@; unset -f f; }; f'
alias re='f(){ d rm -fsv $@ && d up -d $@; unset -f f; }; f'
alias ds="d exec php zsh -l"
alias dsx="d exec php_xdebug zsh -l"
alias de="d exec "
alias dip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias lzd='lazydocker -f ./.docker/docker-compose.yml'

if type exa > /dev/null; then
  alias l="exa -l --group-directories-first"
  alias la="exa -lag --group-directories-first"
  # List only directories and symbolic links that point to directories
  alias lsd='exa -ldg --group-directories-first *(-/DN)'
  # List only file beginning with "."
  alias lsa='exa -ldg --group-directories-first .*'
else
  alias l="ls -F"
  alias ll="ls -h -l "
  alias la="ls -a"
  # List only directories and symbolic links that point to directories
  alias lsd='ls -ld *(-/DN)'
  # List only file beginning with "."
  alias lsa='ls -ld .*'
fi

if [[ -f /etc/arch-release ]] || [[ -f /etc/debian_version ]]; then
  alias grep="grep --color=auto"
fi
alias know="vim ${HOME}/.ssh/known_hosts"
alias mc="mc --nosubshell"
alias reload!=". ${HOME}/.zshrc"
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done
