# key=(
#     BackSpace  "${terminfo[kbs]}"
#     Home       "${terminfo[khome]}"
#     End        "${terminfo[kend]}"
#     Insert     "${terminfo[kich1]}"
#     Delete     "${terminfo[kdch1]}"
#     Up         "${terminfo[kcuu1]}"
#     Down       "${terminfo[kcud1]}"
#     Left       "${terminfo[kcub1]}"
#     Right      "${terminfo[kcuf1]}"
#     PageUp     "${terminfo[kpp]}"
#     PageDown   "${terminfo[knp]}"
# )

bindkey '^w' backward-kill-word
bindkey '^h' backward-delete-char
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kbs]}" backward-kill-dir
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down