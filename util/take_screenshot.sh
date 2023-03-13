#!/bin/sh

tmp_filename="$( openssl rand -hex 4 ).png"
tmp_path="/tmp/${tmp_filename}"

flameshot gui -r > "${tmp_path}" 2> /dev/null

if [ "$( wc -l < "${tmp_path}" )" != 0 ]; then
  scp "${tmp_path}" "wfrsk.dev:/srv/http/static/uploads/${tmp_filename}"
  
  [ "$?" = 0 ] && echo "https://uploads.static.wfrsk.dev/${tmp_filename}" | xclip -selection clipboard
fi

rm -f "${tmp_path}"