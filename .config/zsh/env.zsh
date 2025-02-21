HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000
# Share history between tmux windows
setopt SHARE_HISTORY

# Treat \, . and _ as word-boundaries
WORDCHARS=${WORDCHARS/\/}
WORDCHARS=${WORDCHARS/_}
WORDCHARS=${WORDCHARS/.}

# Browser
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
else
  export BROWSER='xdg-open'
fi

# Editors
export EDITOR='vim'
export GIT_EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi
export LC_ALL='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'

export ANDROID_HOME=${HOME}/Applications/Android/Sdk
export ANDROID_SDK_ROOT=${HOME}/Applications/Android/Sdk
export ANDROID_NDK_ROOT=${ANDROID_SDK_ROOT}/ndk/28.0.12433566
export ANDROID_NDK_HOME=${HOME}/Applications/Android/Sdk/ndk/28.0.12433566
export ANDROID_API=29

export MOZ_ENABLE_WAYLAND=1

export KUBECONFIG=${HOME}/.config/kube/config

export TERMINAL=kitty

export PAGER=most

export GREP_COLORS='mt=38;5;202'

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;67m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;33;65m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;172m' # begin underline
export LESS=-r

[[ -z $TMUX ]] && export TERM="xterm-256color"

# Makeflags
export MAKEFLAGS="-j$(nproc)"

# Midnight commander wants this:
export COLORTERM=truecolor

export GOPATH=${HOME}/Projects/Go
export GOBIN=${GOPATH}/bin

if [[ -e /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# nnn file manager
export NNN_FIFO="/tmp/nnn.fifo nnn"
export NNN_PLUG="p:preview-tui;w:wall;j:autojump;i:imgview;d:diffs"
export NNN_OPENER="xdg-open"
export NNN_OPENER_DETACH=1
export NNN_COLORS="4321"
export NNN_FCOLORS="c1e2431c006025f7a2d6aba0"
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
export NNN_BMS='h:~;i:~/Pictures;d:~/Downloads;p:~/Projects;c:~/Projects/Clients'
export ICONLOOKUP=1
export USE_PISTOL=0
export PISTOL_DEBUG=0

# Exa https://the.exa.website/docs/colour-themes
#
#  Permissions                        File sizes                       Hard links                    Details and metadata
#
#    ur User +r bit                       sn Size numbers                  lc Number of links            xx Punctuation
#    uw User +w bit                       sb Size unit                     lm A multi-link file          da Timestamp
#    ux User +x bit (files)               df Major device ID                                             in File inode
#    ue User +x bit (file types)          ds Minor device ID           Git                               bl Number of blocks
#    gr Group +r bit                                                                                     hd Table header row
#    gw Group +w bit                  Owners and Groups                    ga New                        lp Symlink path
#    gx Group +x bit                                                       gm Modified                   cc Control character
#    tr Others +r bit                     uu A user that’s you             gd Deleted
#    tw Others +w bit                     un A user that’s not             gv Renamed                Overlays
#    tx Others +x bit                     gu A group with you in it        gt Type change
#    su Higher bits (files)               gn A group without you                                         bO Broken link path
#    sf Higher bits (other types)
#    xa Extended attribute marker
#
export EXA_COLORS="da=38;5;67:sn=38;5;28:uu=38;5;65:sb=38;33"

eval "$(zoxide init zsh --cmd j)"

# load Rust env
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# Load aliases in LC_LOCAL_ALIASES so we can use it on remote machines
export LC_LOCAL_ALIASES="$(cat ~/dotfiles/.config/zsh/alias.zsh)"

# Disabled because of slowness
# # Ruby version manager
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#
# # Node version manager
# export NVM_DIR="$HOME/.nvm"
# [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
#
# if (( $+commands[luarocks] )); then
#     eval `luarocks path --bin`
# fi

path=(\
    ${GOBIN} \
    ${HOME}/.cargo/bin \
    ${HOME}/.gem/ruby/2.5.0/bin \
    ${HOME}/.local/bin \
    ${HOME}/bin \
    ${HOME}/.composer/vendor/bin \
    ./vendor/bin \
    ${HOME}/.node/bin \
    ${HOME}/.npm-packages/bin \
    ${HOME}/.rvm/bin \
    ${HOME}/Applications/Android/Sdk/tools/bin \
    ./bin \
    $path\
    /opt/atlassian/plugin-sdk/bin \
    )
export PATH
