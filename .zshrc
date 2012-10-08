autoload -U compinit promptinit
compinit
promptinit
PROMPT="%U@%m/%1~%u%# "
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
