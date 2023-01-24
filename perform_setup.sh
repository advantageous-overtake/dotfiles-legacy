#!/bin/env zsh

eval "$(tail -n +4 $0)" | column -t && return

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

# Skip specific parts for Termux
SKIPPED_SCRIPT_DIRECTORIES=(desktop_env systemd)

for setup_script in `find $( dirname $0 )/config -type f -name "perform_setup.sh" -executable`; do
  directory_name=`basename $( dirname $setup_script )`    
  if [ -z ${TERMUX_VERSION+x} ]; then
    [ -f $setup_script ] && . $setup_script
  elif [ $SKIPPED_SCRIPT_DIRECTORIES[(I)$directory_name] = 0 ]; then
    [ -f $setup_script ] && . $setup_script
  fi
done

unset current_directory SYMLINK_TARGETS