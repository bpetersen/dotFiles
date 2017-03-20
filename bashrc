# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

osName=`uname`

# Load bash git prompt
if [ "$osName" = "Darwin" ]; then
    if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
        GIT_PROMPT_THEME=Default
        source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
    fi
fi

if [ "$osName" = "Linux" ]; then
    if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
        GIT_PROMPT_THEME=Default
        source "$HOME/.bash-git-prompt/gitprompt.sh"
    fi
fi

export NVM_DIR="/Users/bpetersen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export CLICOLOR=1
# export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export EDITOR=nvim

alias vim='nvim'
alias rundev='~/repos/dotFiles/scripts/dev.sh'


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
