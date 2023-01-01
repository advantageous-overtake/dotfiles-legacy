#!/bin/sh
temp_file=$(mktemp -u --suffix=".png")

flameshot gui -r > $temp_file

target_filename=$( openssl rand -hex 4 )

scp $temp_file wfrsk.dev:/srv/http/static/uploads/$target_filename.png

echo https://uploads.wfrsk.dev/$target_filename | xclip -selection clipboard