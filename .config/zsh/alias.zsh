if [ $(uname) = Darwin ]; then
  alias ls='/usr/local/bin/gls --color=auto'
elif command -v eza > /dev/null; then
  alias ls='eza --group-directories-first'
fi

# Kitty
# https://gist.github.com/katef/fb4cb6d47decd8052bd0e8d88c03a102
# https://twitter.com/thingskatedid/status/1316074032379248640
alias icat="kitty +kitten icat --align left"
alias kd="kitty +kitten diff"

# nnn iconlookup likes gawk (GNU awk)
alias awk=gawk

if command -v fdfind > /dev/null; then
  alias fd=fdfind
else
  alias fd=find
fi

if command -v batcat > /dev/null; then
  alias bat=batcat
  alias c=batcat
  alias b=batcat
  alias bp="batcat -p"
else
  alias bat=cat
  alias c=cat
  alias b=cat
  alias bp=cat
fi

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Shortcuts
alias ci="cargo install --path ."
alias g="git"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gd="git diff"
alias gp="git push"
alias gs="git status"
alias h="history"
alias n="nnn -e -Pp"
alias open="xdg-open"
alias o="xdg-open"

# Vim shortcuts
if command -v nvim > /dev/null; then
  alias vi=nvim
  alias v=nvim
else
  alias vi=vim
  alias v=vi
fi

alias vv="vim \$(z)"

# Docker
alias dbd="./.docker/bin/dump.sh"
alias dp="docker ps"
alias down='f(){ d rm -fsv $@; unset -f f; }; f'
alias up='f(){ d build && d up -d $@; unset -f f; }; f'
alias re='f(){ d rm -fsv $@ && d build && d up -d $@; unset -f f; }; f'
alias ds="d exec php zsh -l"
alias dsx="d exec php_xdebug zsh -l"
alias de="d exec "
alias dip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias lzd='lazydocker -f ./.docker/docker-compose.yml'

if command -v eza > /dev/null; then
  alias l="eza -l --group-directories-first"
  alias la="eza -lag --group-directories-first"
  # List only directories and symbolic links that point to directories
  alias lsd='eza -ldg --group-directories-first *(-/DN)'
  # List only file beginning with "."
  alias lsa='eza -ldg --group-directories-first .*'
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
