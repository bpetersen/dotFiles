if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
eval $(/usr/libexec/path_helper -s)
HISTFILE=~/.bash_history
HISTSIZE=100000
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S"
PROMPT_COMMAND='history -a'
