#!/bin/env zsh

current_directory=$( dirname "$( pwd -L )/${0}" )

systemd_local="$HOME/.config/systemd/user"

declare -A SYMLINK_TARGETS=(
  [ssh-agent.service]=$systemd_local/ssh-agent.service
)

for target in "${(@k)SYMLINK_TARGETS}"; do
  link="${SYMLINK_TARGETS[${target}]}"
  mkdir -p $( dirname $link )
  target=`realpath --relative-to=$( dirname $link ) $current_directory/$target`  
  [ `readlink $link | wc -l` = 0 ] || [ `readlink $link` != $target ] && ln -S "-old" -sbfv $target $link
done

unset current_directory SYMLINK_TARGETS