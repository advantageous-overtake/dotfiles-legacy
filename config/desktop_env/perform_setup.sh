#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

[ $( readlink $HOME/.xinitrc | wc -l ) = 0 ] || [ $( readlink $HOME/.xinitrc ) != $current_directory/.xinitrc ] && ln -S "-old" -sbfv $current_directory/.xinitrc $HOME
[ $( readlink $HOME/.xserverrc | wc -l ) = 0 ] || [ $( readlink $HOME/.xserverrc ) != $current_directory/.xserverrc ] && ln -S "-old" -sbfv $current_directory/.xserverrc $HOME
chmod +x $current_directory/.x*rc 

mkdir -p $HOME/.config

[ $( readlink $HOME/.config/i3/config | wc -l ) = 0 ] || [ $( readlink $HOME/.config/i3/config ) != $current_directory/i3-config ] && mkdir -p $HOME/.config/i3 && ln -S "-old" -sbfv $current_directory/i3-config $HOME/.config/i3/config

[ $( readlink $HOME/.config/user-dirs.dirs | wc -l ) = 0 ] || [ $( readlink $HOME/.config/user-dirs.dirs ) != $current_directory/user-dirs.dirs ] && ln -S "-old" -sbfv $current_directory/user-dirs.dirs $HOME/.config

[ $( readlink $HOME/.config/picom/picom.conf | wc -l ) = 0 ] || [ $( readlink $HOME/.config/picom/picom.conf ) != $current_directory/picom.conf ] && mkdir -p $HOME/.config/picom && ln -S "-old" -sbfv $current_directory/picom.conf $HOME/.config/picom

