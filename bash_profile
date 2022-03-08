if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
eval $(/usr/libexec/path_helper -s)

. /usr/local/opt/asdf/asdf.sh

. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
