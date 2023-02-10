#!/bin/bash

applications_unfiltered=$( find /usr/share/applications $HOME/.local/share/applications -name "*.desktop" -type f | tr "\n" " " )

applications=()

# build a lookup table [prop:Name] -> [prop:Exec]
declare -A name_associates=()

function has_property() {
  grep -Eo "$2=.*" < $1 | head -1 | wc -l
}

function read_property() {
  grep -Eo "$2=.*" < $1 | head -1 | awk -F "=" '{ for(i=2; i<=NF; i++) print $i }'
}

# convert to dash-case
function normalize_ident() {
  echo $1 | tr " " "-" | tr '[:upper:]' '[:lower:]'
}

for entry_path in $applications_unfiltered; do
  ! (( `has_property $entry_path "Name"` )) && continue
  ! (( `has_property $entry_path "Exec"` )) && continue
  (( `has_property $entry_path "Hidden"` )) && [ `read_property $entry_path "Hidden"` = "true" ] && continue   
  (( `has_property $entry_path "NoDisplay"` )) && [ `read_property $entry_path "NoDisplay"` = "true" ] && continue

  application_name=$( normalize_ident "`read_property $entry_path "Name"`" )
  bare_name=$( basename "${entry_path}" | rev | cut -b9- -z | rev )
  applications+=( $( echo -ne "${application_name} icon\x1f${bare_name}\n" ) )
done

chosen_application=$( echo -ne "${applications[@]}" | tr " " "\n"| rofi -config $HOME/.rofi -dmenu )

gtk-launch $chosen_application > /dev/null

# if it fails to launch, use a terminal
[ $? != 0 ] && i3-sensible-terminal -e "$chosen_application" & || exit

disown