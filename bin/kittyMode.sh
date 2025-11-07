#!/usr/bin/env bash
# See ~/bin/dusktodawn or ~/Projects/Rust/dusktodawn
# */5 * * * * ~/bin/kittyMode.sh

declare -A kitty_background
kitty_background=(
  [dark]="#000000"
  [light]="#fdf6e3"
)
declare -A kitty_foreground
kitty_foreground=(
  [dark]="#c0c0c0"
  [light]="#333333"
)
declare -A kitty_background_image
kitty_background_image=(
  [dark]="${HOME}/Pictures/Backgrounds/termBg.png"
  [light]="${HOME}/Pictures/Backgrounds/termBg.day.png"
)
declare -A bat_theme
bat_theme=(
  [dark]="OneHalfDark"
  [light]="OneHalfLight"
)
declare -A iconlookup_dirtxt
iconlookup_dirtxt=(
  [dark]="67"
  [light]="67"
)
declare -A iconlookup_filetxt
iconlookup_filetxt=(
  [dark]="250"
  [light]="238"
)

# Needed to run from cron
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export PATH=/bin:/usr/bin/:/usr/local/bin

# Is it light or dark?
nowHourMin=$(date +%s)

mode=dark
if [ $nowHourMin -ge $(${HOME}/bin/dusktodawn --dusk) ] && [ $nowHourMin -lt $(${HOME}/bin/dusktodawn --dawn) ]; then
  mode=light
fi

if [ "$1" != "" ]; then
  mode=$1
fi

# Should we recreate the config files for zsh and kitty?
nowTimestamp=$(date +%s)
aWhileAgo=$(expr $nowTimestamp - 300)
recreate=false

kittyThemeEnvironment="${ZDOTDIR:-${HOME}}/.config/kitty/env.conf"
if [[ ! -s "$kittyThemeEnvironment" || $(stat --format=%Y $kittyThemeEnvironment) -le $aWhileAgo ]]; then
  recreate=true
fi

zshThemeEnvironment="${ZDOTDIR:-${HOME}}/.config/zsh/themes/env.zsh"
if [[ ! -s "$zshThemeEnvironment" || $(stat --format=%Y $zshThemeEnvironment) -le $aWhileAgo ]]; then
  recreate=true
fi

if [ "$1" != "" ] || ($recreate); then
  # Debug
  # notify-send 'KittyMode' "Refreshing kitty theme file" -a 'KittyMode' -i "/usr/lib/kitty/logo/kitty.png"

  rm $kittyThemeEnvironment
  echo "# This file is generated automatically, do not edit by hand!" >$kittyThemeEnvironment
  echo "# $(date)" >>$kittyThemeEnvironment
  echo "# Edit ~/bin/kittyMode.sh instead!" >>$kittyThemeEnvironment

  rm $zshThemeEnvironment
  echo "# This file is generated automatically, do not edit by hand!" >$zshThemeEnvironment
  echo "# $(date)" >>$zshThemeEnvironment
  echo "# Edit ~/bin/kittyMode.sh instead!" >>$zshThemeEnvironment

  # New terminals
  echo "background_image ${kitty_background_image[$mode]}" >>$kittyThemeEnvironment
  echo "background ${kitty_background[$mode]}" >>$kittyThemeEnvironment
  echo "foreground ${kitty_foreground[$mode]}" >>$kittyThemeEnvironment

  # New zsh prompt and bat themes
  echo "export BAT_THEME=\"${bat_theme[$mode]}\"" >>$zshThemeEnvironment
  echo "export IL_C_DIRTXT=\"${iconlookup_dirtxt[$mode]}\"" >>$zshThemeEnvironment
  echo "export IL_C_FILETXT=\"${iconlookup_filetxt[$mode]}\"" >>$zshThemeEnvironment
fi

# Active terminals
if pgrep -x kitty >/dev/null
then
  for p in `pidof kitty`;
  do
    kitty @ --to unix:/tmp/kitty-$p set-colors -a background=${kitty_background[$mode]} foreground=${kitty_foreground[$mode]}
    kitty @ --to unix:/tmp/kitty-$p set-background-image "${kitty_background_image[$mode]}"
  done
fi

# Gnome color-scheme
gsettings set org.gnome.desktop.interface color-scheme prefer-$mode
