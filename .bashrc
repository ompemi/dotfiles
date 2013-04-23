# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

#Git autocompletion
source ~/.git-completion.bash

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi


#Show git branch in prompt
# git branch 2> /dev/null | sed "s/^\* \([^ ]*\)/\1/;tm;d;:m"
function parse_git_branch {
    git rev-parse --git-dir > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        git_status="$(git status 2> /dev/null)"
        branch_pattern="^# On branch ([^${IFS}]*)"
        detached_branch_pattern="# Not currently on any branch"
        remote_pattern="# Your branch is (.*) of"
        diverge_pattern="# Your branch and (.*) have diverged"
        untracked_pattern="# Untracked files:"
        new_pattern="new file:"
        not_staged_pattern="Changes not staged for commit"

        #files not staged for commit
        if [[ ${git_status}} =~ ${not_staged_pattern} ]]; then
            state="✔"
        fi
        # add an else if or two here if you want to get more specific
        # show if we're ahead or behind HEAD
        if [[ ${git_status} =~ ${remote_pattern} ]]; then
            if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
                remote="↑"
            else
                remote="↓"
            fi
        fi
        #new files
        if [[ ${git_status} =~ ${new_pattern} ]]; then
            remote="+"
        fi
        #untracked files
        if [[ ${git_status} =~ ${untracked_pattern} ]]; then
            remote="✖"
        fi
        #diverged branch
        if [[ ${git_status} =~ ${diverge_pattern} ]]; then
            remote="↕"
        fi
        #branch name
        if [[ ${git_status} =~ ${branch_pattern} ]]; then
            branch=${BASH_REMATCH[1]}
        #detached branch
        elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
            branch="NO BRANCH"
        fi

        echo "(${branch}${state}${remote})"
    fi
    return
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    # Old config with full path: PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W $(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # Old config with full path: PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


######################################################################################
# ALIASES
######################################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Easier navigation: .., ..., ...., .....,
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias p="pwd"

alias tree='tree -C --charset=utf8'                                                                                                                                                                 
alias vi='vim'                                                                                                                                                                                      
alias less='less -r'    
alias rm='rm -i'  
alias df="df -h"      
alias more='less'
alias mkdir='mkdir -p'
alias duse='du -k --max-depth=1 | sort +0 -8 -b -n -r'                                                                                                                                                                                
alias today='date +"%A, %B %d, %Y"'
alias recent='ls -lAt | head'

alias curl="curl -I"        
alias httpserver="python -m SimpleHTTPServer"
alias fixdropbox='sudo echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches'

alias sshpkey='cat ~/.ssh/id_rsa.pub | ssh $1 "cat - >> ~/.ssh/authorized_keys2"'

alias pac='tar cvf'
alias pacz='tar czvf'
alias upac='tar xvf'
alias upacz='tar xvzf'


alias myexamplecmd="
    echo 'screen -r';
    echo '$_ # last command parameters';
    echo 'siege -c20 www.google.co.uk -b -t30s';
    echo 'sudo ngrep -q -W byline search www.google.com and port 80';
    echo '';
    echo 'find . -maxdepth 3 -type d -exec xx \;';
    echo 'find ./* -name '*.json' -print | xargs grep 'http:' | tail';
    echo '';
    echo 'for i in \$(seq -w 053 081); do echo;';
    echo '  http://$i.mp3;';
    echo 'done | xargs -n 1 -P 5 wget';
    echo 'awk '{sum=sum+$1}END{print sum ' TB'}'';
    echo '';
    echo 'for i in \$(git status | grep modified | sed -e 's/.*modified: *//'); do git add $i; done';
    echo '';
    echo 'cat log.log | grep Finish | awk '{print $8}' | sort | tr '\n' ','';
    echo '';
    echo 'sshfs -o workaround=rename $USER@host:/project /home/$USER/project';
    echo 'sshfs root@lemon2build03:/tmp ./test';
    "

alias myexamplegit="
    echo 'git clone -b devel ssh://peram@gitgw.cern.ch:10022/punch-modules';
    echo 'git config --global user.name 'Omar Pera'';
    echo 'git config --global user.email campbell.sx@gmail.com';
    echo '';
    echo 'git commit --amend'
    echo ''
    echo 'git diff --cached'
    echo 'git add -p'
    echo 'git checkout -- FILES # Remove unstaged changes'
    echo 'git commit --amend'
    echo '';
    echo '# Workflow branch';
    echo 'git branch';
    echo 'git checkout -b MyFix # git branch MyFix;git checkout MyFix;';
    echo 'git commit -m';
    echo '';
    echo 'git checkout devel';  
    echo 'git branch';
    echo 'git pull';
    echo 'git rebase MyFix';
    echo '';
    echo 'git push --dry-run';
    echo 'git push';
    echo 'git push origin master';
    echo 'git branch -d MyFix # delete it.';
    "

######################################################################################
# EXPORTS
######################################################################################


export EDITOR=vim
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$EDITOR    


export PATH=${PATH}:/home/ompemi/eclipses/eclipse-3.5/omar-stuff/android-sdk-linux_86/tools
export PATH=${PATH}:/home/ompemi/eclipses/eclipse-3.5/omar-stuff/android-sdk-linux_86/platform-tools
export PATH=${PATH}:/home/ompemi/eclipses/eclipse-3.5/omar-stuff/google_appengine

# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
# export PIP_VIRTUALENV_BASE=$WORKON_HOME
# alias mkvirtualenv='mkvirtualenv --no-site-packages --distribute'

# export LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.4/client/lib
# export ORACLE_HOME=/usr/lib/oracle/10.2.0.4/client
# export SQLPATH=$ORACLE_HOME/sqlplus
# export PATH=$ORACLE_HOME/bin:$PATH

# Dropbox
# echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches



######################################################################################
# SHORTCUTS TO DIRECTORIES
######################################################################################

function cdp {
case $1 in
  "home-python")
    cd /home/ompemi/workspaces/eclipse-3.5/python/ ;;
  "home-android")
    cd /home/ompemi/workspaces/eclipse-3.5/android/ ;;
  "cern-zend")
    cd /root/Zend/workspaces/DefaultWorkspace7/ ;;
  "cern-afs")
    cd /afs/cern.ch/user/p/peram/ ;;
  *)
    echo "Options:"
    echo ""
    echo "  home-python"
    echo "  home-android"
    echo "  cern-zend"
    echo "  cern-afs"
esac
}

# put this in /etc/bash_completition.d/cdp

_cdp_show()
{
        local cur opts

        cur="${COMP_WORDS[COMP_CWORD]}"
        opts=$(cdp | tail -n+2)
        COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
}
complete -F _cdp_show cdp


