# [ -z $ZELLIJ ] && [ $( where zellij | wc -l ) != 0 ] && zellij && exit

export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ -d $HOME/games ]; then
  GAME_DIRECTORIES=$( /bin/ls $HOME/games | xargs -I{} printf ":%s/games/%s" $HOME {} )

  export PATH=$PATH$GAME_DIRECTORIES # the ':' is automatically added.
fi

eval $(luarocks path)

CASE_SENSITIVE="true"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto

zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_AUTO_TITLE="true"

ZSH_DISABLE_COMPFIX="true"

plugins=(git)

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

export EDITOR="vim"

[ -z $SSH_CONNECTION ] && export EDITOR="helix"

export ARCHFLAGS="-arch x86_64"

[ -f $HOME/.oh-my-zsh/oh-my-zsh.sh ] && source $HOME/.oh-my-zsh/oh-my-zsh.sh

alias cat="bat"
alias ls="lsd -1 -l --icon never --date relative"
alias cd="z"
alias sudo="doas"
alias edit=$EDITOR

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

pfetch
