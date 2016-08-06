if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Default
    source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
else
    source "~/.bash-git-prompt/gitprompt.sh"
fi

export NVM_DIR="/Users/bartonpetersen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export CLICOLOR=1
# export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export EDITOR=nvim

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
