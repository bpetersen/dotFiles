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
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
        # if not found in /usr/local/etc, try the brew --prefix location
        [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
            . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
    }
fi

if [ "$osName" = "Linux" ]; then
    if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
        GIT_PROMPT_THEME=Default
        source "$HOME/.bash-git-prompt/gitprompt.sh"
    fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export EDITOR=nvim

alias vim='nvim'
alias rundev='~/repos/dotFiles/scripts/dev.sh'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
