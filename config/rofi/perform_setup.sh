#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

usr_config="$HOME/.config"
local_share="$HOME/.local/share"

rofi_config="${usr_config}/rofi"
rofi_share="${local_share}/rofi"

[ $( readlink $rofi_config ) = $current_directory ] && return
[ $( readlink $rofi_share ) = $current_directory ] && return

# if a rofi and rofi-old files already exist, add a random suffix to rofi-old
[ -d $rofi_config ] && [ -d "${rofi_config}-old" ] && mv "${rofi_config}-old" "${rofi_config}-$( openssl rand -base64 3 )"
[ -d $rofi_share ] && [ -d "${rofi_share}-old" ] && mv "${rofi_share}-old" "${rofi_share}-$( openssl rand -base64 3 )"

# if the config folder already exists, make a backup
[ -d $rofi_config ] && mv $rofi_config "${rofi_config}-old"
[ -d $rofi_share ] && mv $rofi_share "${rofi_share}-old"

mkdir -p $usr_config $local_share

ln -sfv $current_directory $usr_config
ln -sfv $current_directory $local_share