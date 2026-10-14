# ~/.bashrc — portable. Sources ~/.shell_common.
case $- in *i*) ;; *) return;; esac

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.shell_common ]; then
  . ~/.shell_common
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# color ls via dircolors (Linux) or CLICOLOR (macOS)
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
elif [ "$(uname -s)" = "Darwin" ]; then
  export CLICOLOR=1
  alias ls='ls -G'
fi

# bash completion (guarded, both OSes)
if ! shopt -oq posix 2>/dev/null; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
  fi
fi
