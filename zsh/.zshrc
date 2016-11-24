# Set prompt
autoload -U colors && colors
PROMPT="%F{250}%K{240 }%n %f%k%F{124}%K{202} %m %f%k%F{015}%K{031} %2~ %f%k%F{015}%K{104} %# %f%k"
RPROMPT="[%F{15}%K{161}%?%f%k]"

# History file
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify completeinword completealiases histignorealldups
bindkey -e

#Put current directory path in window title
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

# Resize text area of terminal to 140x40
print -Pn "\e[8;50;120t"

# Print current window position
echo -en '\e[13t'

# Read it to a variable
read -sd t CURPOS

# Extract the X, Y from the variable
CURPOS="${CURPOS#*;}"
Y="${CURPOS#*;}"
X="${CURPOS%;*}"
# If X is larger than 390 reposition the window to 390
if ((X > 410)); then
  print -Pn "\e[3;410;${Y}t"
fi

# Set top command colours
export TOPCOLORS="header=,#1\
:1min=,399#32:1min=400,799#33:1min=800,#31\
:5min=,299#32:5min=300,599#33:5min=600,#31\
:15min=,199#32:15min=200,399#33:15min=400,#31\
:cpu.user=,9#32:cpu.user=10,49#33:cpu.user=50,#31\
:cpu.system=,9#32:cpu.system=10,49#33:cpu.system=50,#31\
:cpu.interrupt=,9#32:cpu.interrupt=10,49#33:cpu.interrupt=50,#31"

# Set cheat colours
export CHEATCOLORS=true

# Set Generic alias
alias path='echo $PATH | tr : "\n"'
alias ldpath='echo $LD_LIBRARY_PATH | tr : "\n"'
alias ncdu='ncdu --exclude .snapshot'
fd () {
  if (( $# == 0 )); then
    \du -hs --exclude=.snapshot * | sort -rh | head -10
  else
    \du -hs --exclude=.snapshot "$@"/* | sort -rh | head -10
  fi
}
rmd () { rm -rf $(ls -1 -d */) }
dk () { 
  if (( $# == 0 )); then
    echo usage: dk line_nr ...;
  fi
  for i
    do
      sed -i -e ${i}d ~/.ssh/known_hosts
    done
}
# listing stuff
alias ls="ls --color"
# Execute \kbd{ls -lSrah}
alias dir="ls -lSrah"
# Only show dot-directories
alias lad='ls -d .*(/)'
# Only show dot-files
alias lsa='ls -a .*(.)'
# Only files with setgid/setuid/sticky flag
alias lss='ls -l *(s,S,t)'
# Only show symlinks
alias lsl='ls -l *(@)'
# Display only executables
alias lsx='ls -l *(*)'
# Display world-{readable,writable,executable} files
alias lsw='ls -ld *(R,W,X.^ND/)'
# Display the ten biggest files
alias lsbig="ls -flh *(.OL[1,10])"
# Only show directories
alias lsd='ls -d *(/)'
# Only show empty directories
alias lse='ls -d *(/^F)'

alias la='ls -la'
alias ll='ls -l'
alias lh='ls -hAl'
alias l='ls -l'


# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Syntax Highlight
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History Substring Search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Completions
source ~/.zsh/zsh-completions/zsh-completions.zsh

# Bind keys
TERM=xterm-256color
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[2~" overwrite-mode
bindkey "\e[D"  backward-char
bindkey "\e[C"  forward-char
bindkey "\e[Z"  reverse-menu-complete
bindkey "\e[A"  history-substring-search-up
bindkey "\e[B"  history-substring-search-down


