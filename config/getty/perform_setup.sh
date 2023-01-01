#!/bin/sh

# early return if not superuser
[ $UID != 0 ] && return

current_directory=$( dirname "$( pwd -L )/${0}" )

[ -f /etc/issue ] && mv /etc/issue /etc/issue-old

mv "${current_directory}/issue" /etc

# early return if not using systemd
[ $( readlink $( where init ) | grep systemd | wc -l ) = 0 ] && return

mv "${current_directory}/getty@.service" "/lib/systemd/system" 