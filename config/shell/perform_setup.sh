#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

ln -S "-old" -sbfv $current_directory/.zshrc $HOME
ln -S "-old" -sbfv $current_directory/.zprofile $HOME

mkdir $HOME/.config

ln -S "-old" -sbfv $current_directory/starship.toml $HOME/.config