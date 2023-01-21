#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

declare -A SYMLINK_TARGETS=(
  [xinitrc]=$HOME/.xinitrc
  [xserverrc]=$HOME/.xserverrc
  [i3wm]=$HOME/.i3wm
  [picom]=$HOME/.picom
  [rofi]=$HOME/.rofi
  [rofi_themes]=$HOME/.rofi_themes
  [rkeep]=$HOME/.rkeep.conf
  [user-dirs.dirs]=$HOME/.config/user-dirs.dirs
)

for target in "${(@k)SYMLINK_TARGETS}"; do
  link="${SYMLINK_TARGETS[${target}]}"
  mkdir -p $( dirname $link )
  target=`realpath --relative-to=$( dirname $link ) $current_directory/$target` 
  [ `readlink $link | wc -l` = 0 ] || [ `readlink $link` != $target ] && ln -S "-old" -sbfv $target $link
done

unset current_directory SYMLINK_TARGETS
