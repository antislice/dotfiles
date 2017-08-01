autoload -U compinit promptinit
autoload -U colors && colors
compinit
promptinit
setopt prompt_subst

# turn off errors if a pattern for a filename generation doesn't have a match
# allows me to use rake task arguments without escaping the [ ]s
unsetopt nomatch

prompt_command() {
    # %{ and %} act as markup indicators, so the colors don't screw up the spacing

    # run commands and save them in variables
    branch=`git symbolic-ref HEAD 2> /dev/null | cut -f3 -d/`
    if [ ! -z ${branch} ]; then
      if [ ${branch} '==' 'master' ]; then
        branch=`echo " %{$fg[cyan]%}${branch}%{$reset_color%}"`
      else
        branch=`echo " %{$fg[magenta]%}${branch}%{$reset_color%}"`
      fi
    fi # shell scripting looks funny sometimes, this is an "end" in ruby
    changes=`git status -s 2> /dev/null | \
             wc -l | sed -e 's/ *//'`
		# ^^^^ notice all the output redirection!
    if [ ${changes} -eq 0 ]; then
      dirty=""
    else
      dirty="%{$fg[red]%}*%{$reset_color%}"
    fi
    # echo is how I got it to return a value
    echo "%U@%m/%~%u${branch}${dirty} 
%#> "
}

# change tab/window title to show PWD
precmd () {print -Pn "\e]0;%~\a"}

PROMPT='$(prompt_command)'

export NODE_PATH="/usr/local/lib/node"
PATH=$PATH:/usr/local/share/npm/bin
PATH=$PATH:/usr/local/heroku/bin
# PATH=$PATH:/usr/gosu-1.2-full/gosu-1.2/bin
alias gits='git status'
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

export PYENV_ROOT=/usr/local/var/pyenv
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zhistory
setopt HIST_IGNORE_ALL_DUPS

eval $(docker-machine env)

export OCI_DIR=$(brew --prefix)/lib
