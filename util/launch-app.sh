#!/bin/bash

applications_unfiltered=$( find /usr/share/applications $HOME/.local/share/applications -name "*.desktop" -type f | lua -e "while io.stdin:read(0) do x = io.stdin:read('l'); _ = string.find(x, '%s') == nil and print(x) end" | tr "\n" " " )

applications=()

# build a lookup table [prop:Name] -> [entry-path]
declare -A name_associates=()

function has_property() {
  grep -Eo "$2=.*" < "$1" | head -1 | wc -l
}

function read_property() {
  grep -Eo "$2=.*" < "$1" | head -1 | awk -F "=" '{ for(i=2; i<=NF; i++) print $i }'
}

# convert to dash-case
function normalize_ident() {
  echo "$1" | tr -d "\n" | tr "[:upper:]" "[:lower:]" | tr -d "[!\"\#$%&'()*+,./:;<=>?@\[\\\]^\`{|}~]" | tr "_" "-" | tr "[:space:]" "-"
}

for entry_path in $applications_unfiltered; do
  ! (( `has_property $entry_path "Name"` )) && continue
  ! (( `has_property $entry_path "Exec"` )) && continue
  (( `has_property $entry_path "Hidden"` )) && [ `read_property $entry_path "Hidden"` = "true" ] && continue   
  (( `has_property $entry_path "NoDisplay"` )) && [ `read_property $entry_path "NoDisplay"` = "true" ] && continue

  application_name=$( normalize_ident "`read_property $entry_path "Name"`" )
  applications+=( $( printf "%s%%icon\x1f%s" $application_name `read_property $entry_path "Icon"` ) )
  name_associates+=( [$application_name]="$entry_path" )
done

chosen_application=$( echo -ne "${applications[@]}" | tr " " "\n" | tr "%" "\0" | rofi -config $HOME/.rofi -dmenu -window-title "   Apps " )

dmenu_success=$?

[ $dmenu_success != 0 ] && exit 1

declare -A boolean_mapper=( [true]=1 [false]=0 )

uses_terminal=$( read_property "${name_associates[$chosen_application]}" "Terminal" )

uses_terminal="${uses_terminal:-false}"

uses_terminal="${boolean_mapper[$uses_terminal]}"

application_name=$( read_property "${name_associates[$chosen_application]}" "Name" )
application_exec=$( read_property "${name_associates[$chosen_application]}" "Exec" )

if ! (( $uses_terminal )); then
  gtk-launch $application_name > /dev/null 2>&1
else
  alacritty -e $application_exec &
  disown
fi

