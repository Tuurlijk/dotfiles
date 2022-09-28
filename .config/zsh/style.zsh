
if [[ ${+FAST_HIGHLIGHT_STYLES} = 1 ]]
then
  # Aliases and functions
  FAST_HIGHLIGHT_STYLES[alias]='fg=068'
  FAST_HIGHLIGHT_STYLES[function]='fg=028'

  # Commands and builtins
  FAST_HIGHLIGHT_STYLES[command]="fg=166"
  FAST_HIGHLIGHT_STYLES[hashed-command]="fg=blue"
  FAST_HIGHLIGHT_STYLES[builtin]="fg=202"

  # Paths
  FAST_HIGHLIGHT_STYLES[path]='fg=244'

  # Globbing
  FAST_HIGHLIGHT_STYLES[globbing]='fg=130,bold'

  # Options and arguments
  FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=124'
  FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=124'

  FAST_HIGHLIGHT_STYLES[back-quoted-argument]="fg=065"
  FAST_HIGHLIGHT_STYLES[single-quoted-argument]="fg=065"
  FAST_HIGHLIGHT_STYLES[double-quoted-argument]="fg=065"
  FAST_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=065"
  FAST_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=065"


  FAST_HIGHLIGHT_STYLES[default]='none'
  FAST_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
  FAST_HIGHLIGHT_STYLES[reserved-word]='fg=green'
  FAST_HIGHLIGHT_STYLES[precommand]='none'
  FAST_HIGHLIGHT_STYLES[commandseparator]='fg=214'
  FAST_HIGHLIGHT_STYLES[history-expansion]='fg=blue'

  FAST_HIGHLIGHT_STYLES[assign]='none'

  # PATTERNS
  # rm -rf
  ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=214')

  # Sudo
  ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=white,bold,bg=214')
fi