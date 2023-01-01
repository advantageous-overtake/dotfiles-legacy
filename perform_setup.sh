#!/bin/sh

current_directory=$( dirname "$( pwd -L )/${0}" )

ln -S "-old" -sfv $current_directory/util $HOME

for setup_script in `/bin/find config -type f -name 'perform_setup.sh'`; do
  [ -f $setup_script ] && echo "executing => ${setup_script}"
  [ -f $setup_script ] && . $setup_script
done

