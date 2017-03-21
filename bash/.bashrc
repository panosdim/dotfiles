#!/usr/bin/env bash

# Shell is non-interactive?
[[ $- != *i* ]] && return

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""
    
    # Change color for root or sudo
    if [ "$HOME" == "/root" ]; then
        PS1+="\[\e[48;5;202m\] \u \[\e[m\]"
    else
        if sudo -n uptime 2>&1 | grep -q "load"; then
            PS1+="\[\e[48;5;202m\] \u \[\e[m\]"
        else
            PS1+="\[\e[48;5;32m\] \u \[\e[m\]"
        fi        
    fi
    
    # Add hostname if we ssh
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        PS1+="\[\e[48;5;34m\] \h \[\e[m\]"
    fi

    PS1+="\[\e[48;5;90m\]\`parse_git_branch\`\[\e[m\]\[\e[48;5;240m\] \w \[\e[m\]\[\e[48;5;52m\]\`[ $EXIT -ne 0 ] && echo $EXIT\`\[\e[m\] "
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# Mimic Zsh run-help ability
bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'

# Arrow-up/-down search history based on a mask, one entry at a time
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# Color in man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Don't use ^D to exit
set -o ignoreeof

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Don't put 'history' commands themselves in the history
export HISTIGNORE='history*:h'

# Kepp no more than 1000 lines
export HISTFILESIZE=1000
export HISTSIZE=1000

# Set shell options
shopt -s autocd         # Change to directories without using cd
shopt -s cdable_vars    # Allow to change directory using variable value
shopt -s cdspell        # Correct minor spell errors
shopt -s checkjobs      # Check for running jobs before exit
shopt -s dirspell       # Correct directory spell errors as you type
shopt -s extglob        # Enable extended pattern matching features
shopt -s globstar       # Enable the  pattern **
shopt -s histappend     # Append, don't overwrite history
shopt -s checkwinsize   # Check window size after each command to avoid annoying effects of resizing

# Set alias
source ~/.bashrc.alias

# Use bash-completion, if available
[ -f ~/.bash-completion/bash_completion ] && source ~/.bash-completion/bash_completion

# Use bashmarks
[ -f ~/.bashmarks.sh ] && source ~/.bashmarks.sh

# Disable XON/XOFF flow control (^s/^q)
stty -ixon  
