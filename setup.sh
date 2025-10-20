#!/usr/bin/env zsh

# Logging stuff.
e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()   { echo -e " \033[1;34m➜\033[0m  $@"; }

main () {
    # Take home dir as parameter for use in puppet script
    local home
    if [[ -z $1 ]]
    then
        home=${ZDOTDIR:-${HOME}}
    else
        home=$1
    fi

    # Get the directory in which the script resides
    local dotfileDir=${0:a:h}

    e_header "Creating symlinks..."
    mkdir -p $dotfileDir/backup

    setopt EXTENDED_GLOB
    local ohMyGlob='^(.idea|.git*|.config|Background|bin|backup|Icon|IntelliJ|README*|Screenshots|setup.sh|tags)(D)'
    for dir ('/' '/bin/' '/.config/'); do
        mkdir -p ${home}${dir}
        mkdir -p $dotfileDir/backup${dir}
        for rcfile in ${dotfileDir}${dir}${~ohMyGlob}; do
            local target="${home}${dir}${rcfile:t}"
            [[ -a "${target}" ]] && mv "${target}" "$dotfileDir/backup/${dir}" 2>/dev/null
            if [ $(uname) = Darwin ]; then
                command ln -h -s -F "$rcfile" "${target}"
            else
                command ln -s "$rcfile" "${target}"
            fi
        done
    done

    source $home/.config/zsh/0_functions.zsh
    e_header "Concatenating .config/zsh files into single file..."
    recreateCachedSettingsFile
    e_header "Compiling zsh files for increased speed..."
    compileAllTheThings

    echo
    e_success "All done!"
}

main "$1"
