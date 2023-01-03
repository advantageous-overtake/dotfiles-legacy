#!/bin/sh

[ `echo -n $SHELL | grep 'zsh' | wc -l` = 0 ] && echo "[i] zsh must be used as an interpreter due to zsh-only syntax being in use."

[ $UID != 0 ] && echo "[i] for agetty setup, run as superuser."

current_directory=$( dirname "$( pwd -L )/${0}" )

[ `readlink $HOME/util | wc -l` = 0 ] || [ `readlink $HOME/util` != $current_directory/util ] && ln -S "-old" -sfv $current_directory/util $HOME

for setup_script in `/bin/find config -type f -name "perform_setup.sh"`; do
  [ -f $setup_script ] && . $setup_script
done