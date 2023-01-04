#!/bin/env zsh

current_directory=$( dirname "$( pwd -L )/${0}" )

declare -A SYMLINK_TARGETS=(
  [zshrc]=$HOME/.zshrc
  [zshenv]=$HOME/.zshenv
  [zprofile]=$HOME/.zprofile
  [zlogout]=$HOME/.zlogout
  [starship.toml]=$HOME/.config/starship.toml
)

for target in "${(@k)SYMLINK_TARGETS}"; do
  link="${SYMLINK_TARGETS[${target}]}"
  target=$current_directory/$target
  mkdir -p $( dirname $link )
  [ `readlink $link | wc -l` = 0 ] || [ `readlink $link` != $target ] && ln -S "-old" -sbfv $target $link
done

unset current_directory SYMLINK_TARGETS