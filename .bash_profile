if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

export NVM_DIR="/Users/bartonpetersen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export CLICOLOR=1
# export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
