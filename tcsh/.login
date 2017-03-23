#!/usr/bin/env csh

setenv OPT /home/xigpadi/opt
setenv PATH ${OPT}/bin:/home/tool/bin:${PATH}
setenv LD_LIBRARY_PATH ${OPT}/lib:${LD_LIBRARY_PATH}
setenv MANPATH ${OPT}/share/man:${OPT}/man:${MANPATH}
setenv INFOPATH ${OPT}/share/info
setenv CC gcc
setenv CXX g++

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


