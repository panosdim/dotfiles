#!/usr/bin/env bash

# Shell is non-interactive?
[[ $- != *i* ]] && return

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

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Don't put 'history' commands themselves in the history
export HISTIGNORE='history*:h'

# Keep no more than 1000 lines
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
source ~/.alias

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Disable XON/XOFF flow control (^s/^q)
stty -ixon

# Set colors for ls
eval $(dircolors -b ~/.dircolors)
