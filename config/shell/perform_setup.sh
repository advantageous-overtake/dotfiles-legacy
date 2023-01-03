#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

[ $( readlink $HOME/.zshrc | wc -l ) = 0 ] || [ $( readlink $HOME/.zshrc ) != $current_directory/.zshrc ] && ln -S "-old" -sbfv $current_directory/.zshrc $HOME
[ $( readlink $HOME/.zprofile | wc -l ) = 0 ] || [ $( readlink $HOME/.zprofile ) != $current_directory/.zprofile ] && ln -S "-old" -sbfv $current_directory/.zprofile $HOME

mkdir -p $HOME/.config

[ $( readlink $HOME/.config/starship.toml | wc -l ) = 0 ] || [ $( readlink $HOME/.config/starship.toml ) != $current_directory/starship.toml ] && ln -S "-old" -sbfv $current_directory/starship.toml $HOME/.config