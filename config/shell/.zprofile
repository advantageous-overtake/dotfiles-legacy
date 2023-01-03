[ -e $HOME/.ssh-agent ] || eval `ssh-agent -a $HOME/.ssh-agent` 

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec xinit
fi
