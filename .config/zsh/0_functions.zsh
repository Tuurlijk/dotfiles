#!/bin/zsh
# Function to determine the need of a zcompile. If the .zwc file
# does not exist, or the base file is newer, we need to compile.
# man zshbuiltins: zcompile
zcompare() {
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile ${1}
  fi
}

# The following code helps us by optimizing the existing framework.
# This includes zcompile, zcompdump, etc.
compileAllTheThings () {
  setopt EXTENDED_GLOB
  local zsh_glob='^(.git*|LICENSE|README.md|*.zwc)(.)'

  # zcompile the completion cache; siginificant speedup.
  for file in ${ZDOTDIR:-${HOME}}/.zcomp${~zsh_glob}; do
    zcompare ${file}
  done

  # zcompile .zshrc
  zcompare ${ZDOTDIR:-${HOME}}/.zshrc

  # Zgenom
  zgenom_mods=${ZDOTDIR:-${HOME}}/.zgenom/
  zcompare ${zgenom_mods}init.zsh
  zcompare ${zgenom_mods}zgenom.zsh
  for dir ('/zsh-users/' '/zdharma/' '/robbyrussell/oh-my-zsh-master/plugins/shrink-path/'); do
    if [ -d "${zgenom_mods}${dir}" ]; then
      for file in ${zgenom_mods}${dir}**/*.zsh; do
        zcompare ${file}
      done
    fi
  done
}

# Update dotfiles
rd () {
  e_header "Updating dotfiles..."
  pushd -q "${ZDOTDIR:-${HOME}}/dotfiles/"
  git pull
  if (( $? )) then
    echo
    git status --short
    echo
    e_error "(ノ°Д°）ノ︵ ┻━┻)"
    popd -q
    return 1
  else
    ./setup.sh
  fi
  popd -q
}

# Load all custom settings from one cached file
recreateCachedSettingsFile() {
  setopt EXTENDED_GLOB
  local cachedSettingsFile=${ZDOTDIR:-${HOME}}/.config/zsh/cache/settings.zsh
  local recreateCache=false
  local rcFiles
  if [[ ! -s ${cachedSettingsFile} ]]; then
    recreateCache=true
  else
    rcFiles=(${ZDOTDIR:-${HOME}}/.zgenom/sources/init.zsh)
    rcFiles+=(${ZDOTDIR:-${HOME}}/.config/zsh/*.zsh)
    rcFiles+=(${ZDOTDIR:-${HOME}}/.secrets.zsh)
    for rcFile in $rcFiles; do
      if [[ -s $rcFile && $rcFile -nt $cachedSettingsFile ]]; then
        recreateCache=true
      fi
    done
  fi
  if [[ "$recreateCache" = true ]]; then
    touch $cachedSettingsFile
    echo "# This file is generated automatically, do not edit by hand!" > $cachedSettingsFile
    echo "# Edit the files in ~/.config/zsh instead!" >> $cachedSettingsFile
    # Zgen
    if [[ -s ${ZDOTDIR:-${HOME}}/.zgenom/sources/init.zsh ]]; then
      echo ""               >> $cachedSettingsFile
      echo "#"              >> $cachedSettingsFile
      echo "# Zgen:"        >> $cachedSettingsFile
      echo "#"              >> $cachedSettingsFile
      cat ${ZDOTDIR:-${HOME}}/.zgenom/sources/init.zsh >> $cachedSettingsFile
    fi
    # Rc files
    for rcFile in ${ZDOTDIR:-${HOME}}/.config/zsh/*.zsh; do
      echo ""               >> $cachedSettingsFile
      echo "#"              >> $cachedSettingsFile
      echo "# ${rcFile:t}:" >> $cachedSettingsFile
      echo "#"              >> $cachedSettingsFile
      cat $rcFile           >> $cachedSettingsFile
    done
    # Secrets
    if [ -s ${ZDOTDIR:-${HOME}}/.secrets.zsh ]; then
      echo ""               >> $cachedSettingsFile
      echo "#"              >> $cachedSettingsFile
      echo "# Secrets:"     >> $cachedSettingsFile
      echo "#"              >> $cachedSettingsFile
      cat ${ZDOTDIR:-${HOME}}/.secrets.zsh >> $cachedSettingsFile
    fi
    zcompile $cachedSettingsFile
  fi
}

# Determine local IP address
ips () {
  ifconfig | grep "inet " | awk '{ print $2 }'
}

# Create directory and cd into it
mkcd() {
  if [[ ! -n "$1" ]]; then
    echo "Usage: mkcd [directory]"
  elif [ -d $1 ]; then
    echo "'$1' already exists"
    cd "${1}"
  else
    mkdir -p "${1}" && cd "${1}"
  fi
}

# Create TYPO3 extension archive from current directory
t3x () {
  e_header "Creating TYP3 extension archive..."
  if [[ ! -n "$1" ]]; then
    echo "Usage: mkcd [directory]"
  elif git show-ref --tags v${1} --quiet; then
    git archive -o "../${PWD##*/}_${1}.zip" v${1}
    e_success "Created: ../${PWD##*/}_${1}.zip"
  else
    e_error "Could not find tag: v${1} in current repository. Maybe you need to: git pull?"
  fi
}

# Recreate git folder from existing remote
regit() {
  if [[ ! -n "$1" ]]; then
    echo "Usage: regit [remote]"
  elif [ -d "$1/.git" ]; then
    echo "dir is already under git"
  else
    git init
    if [ -f .gitignore ]; then
      mv .gitignore .gitignore.bak
    fi
    echo * | tr " " "\n" > .gitignore
    echo .* | tr " " "\n" >> .gitignore
    git remote add origin "${1}"
    git fetch
    git checkout origin/main -b main
  fi
}

# Remove last segment of path
backward-kill-dir () {
  local WORDCHARS=${WORDCHARS/\/}
  zle backward-kill-word
}
zle -N backward-kill-dir

# Save ssh auth socket
sshAuthSave() {
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-auth-sock.$HOSTNAME"
}

# Return 'dark' or 'light' based on the time of day
themeMode () {
  # See ~/bin/sunrise-sunset.sh
  # */5 * * * * ~/bin/kittyMode.sh

  location=${LOCATION:-NLXX5790}

  IFS=':'
  read -r sunrise < $HOME/tmp/$location.sunrise
  sunrise=${sunrise/':'/}
  read -r sunset < $HOME/tmp/$location.sunset
  sunset=${sunset/':'/}

  now=`date +%H%M`

  mode=dark
  if [ $now -ge $sunrise ] && [ $now -lt $sunset ]; then
    mode=light
  fi

  if [ "$1" != "" ]; then
    mode=$1
  fi

  echo $mode
}

# Autojump function override. The only change is the output color, which is now a dir color
j () {
	if [[ ${1} == -* ]] && [[ ${1} != "--" ]]
	then
		autojump ${@}
		return
	fi
	setopt localoptions noautonamedirs
	local output="$(autojump ${@})"
	if [[ -d "${output}" ]]
	then
		if [ -t 1 ]
		then
			echo -e "\\033[01;38;5;67m${output}\\033[0m"
		else
			echo -e "${output}"
		fi
		cd "${output}"
	else
		echo "autojump: directory '${@}' not found"
		echo "\n${output}\n"
		echo "Try \`autojump --help\` for more information."
		false
	fi
}

# Shortcut for docker-compose commands. Sometimes the docker-compose.yml file is in the project root and sometimes it
# is in a .docker folder. Sometimes there is an 'extension' file and often not. This function handles those cases.
d () {
  dc=`find ./ -maxdepth 2  -name docker-compose.yml`
  dc_extended=`find ./ -maxdepth 2  -name "docker-compose.*.yml" | head -n 1`
  if [[ ! -z  $dc_extended  ]]; then
    docker-compose -f $dc -f $dc_extended $@
  else
    docker-compose -f $dc $@
  fi
}