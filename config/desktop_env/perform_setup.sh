#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

ln -S "-old" -sbfv $current_directory/.xinitrc $HOME
ln -S "-old" -sbfv $current_directory/.xserverrc $HOME

chmod +x $current_directory/.x*rc 

mkdir -p $HOME/.config/i3 && ln -S "-old" -sbfv $current_directory/i3-config $HOME/.config/i3/config

ln -S "-old" -sbfv $current_directory/user-dirs.dirs $HOME/.config

mkdir -p $HOME/.config/picom && ln -S "-old" -sbfv $current_directory/picom.conf $HOME/.config/picom

