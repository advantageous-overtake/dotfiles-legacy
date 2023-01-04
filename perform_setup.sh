#!/bin/sh

[ `echo -n $SHELL | grep 'zsh' | wc -l` = 0 ] && echo "[i] zsh must be used as an interpreter due to zsh-only syntax being in use." && return

eval "$(tail -n +6 $0)" | column -t && return

current_directory=$( dirname "$( pwd -L )/${0}" )

declare -A SYMLINK_TARGETS=(
  [util]=$HOME/util
)

for target in "${(@k)SYMLINK_TARGETS}"; do
  link="${SYMLINK_TARGETS[${target}]}"
  mkdir -p $( dirname $link )
  target=`realpath --relative-to=$( dirname $link ) $current_directory/$target`  
  [ `readlink $link | wc -l` = 0 ] || [ `readlink $link` != $target ] && ln -S "-old" -sbfv $target $link
done

for setup_script in `find $( dirname $0 )/config -type f -name "perform_setup.sh" -executable`; do
  echo ":: $setup_script"
  [ -f $setup_script ] && . $setup_script
done

unset current_directory SYMLINK_TARGETS