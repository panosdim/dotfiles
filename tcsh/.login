#!/usr/bin/env csh

setenv OPT ${HOME}/opt
set -f path=("${OPT}/bin" $path:q)
fp $LD_LIBRARY_PATH ${OPT}/lib
if ( $? ) setenv LD_LIBRARY_PATH ${OPT}/lib:${LD_LIBRARY_PATH}
fp $MANPATH ${OPT}/man
if ( $? ) setenv MANPATH ${OPT}/man:${MANPATH}
setenv MAN_POSIXLY_CORRECT 1

# Set INPUTRC
setenv INPUTRC /home/xigpadi/.inputrc

# Set color terminal
setenv TERM xterm-256color

# Less with color
setenv LESS_TERMCAP_md `printf "\e[01;31m"`
setenv LESS_TERMCAP_me `printf "\e[0m"`
setenv LESS_TERMCAP_se `printf "\e[0m"`
setenv LESS_TERMCAP_so `printf "\e[01;44;33m"`
setenv LESS_TERMCAP_ue `printf "\e[0m"`
setenv LESS_TERMCAP_us `printf "\e[01;32m"`


