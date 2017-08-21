#!/usr/bin/env csh

# General settings
setenv OPT ${HOME}/opt
setenv JAVA_HOME ${OPT}/jdk1.8.0_131
set -f path=("${OPT}/bin:${JAVA_HOME}/bin" $path:q)
if ( "`echo $LD_LIBRARY_PATH | grep -v ${OPT}/lib`" != "" ) setenv LD_LIBRARY_PATH ${OPT}/lib:${LD_LIBRARY_PATH}
if ( "`echo $MANPATH | grep -v ${OPT}/man`" != "" ) setenv MANPATH ${OPT}/man:${MANPATH}
if ( "`echo $MANPATH | grep -v ${OPT}/share/man`" != "" ) setenv MANPATH ${OPT}/share/man:${MANPATH}
if ( "`echo $PKG_CONFIG_PATH | grep -v ${OPT}/lib/pkgconfig`" != "" ) setenv PKG_CONFIG_PATH ${OPT}/lib/pkgconfig:${PKG_CONFIG_PATH}
if ( "`echo $XDG_DATA_DIRS | grep -v ${OPT}/share`" != "" ) setenv XDG_DATA_DIRS ${OPT}/share:${XDG_DATA_DIRS}
setenv CPATH ${OPT}/include
setenv GSETTINGS_SCHEMA_DIR ${OPT}/share/glib-2.0/schemas
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

# Unset proxy
setenv http_proxy
setenv https_proxy

# Perl local::lib
setenv MODULEBUILDRC "${OPT}/perl5/.modulebuildrc"
setenv PERL_MM_OPT "INSTALL_BASE=${OPT}/perl5"
setenv PERL5LIB "${OPT}/perl5/lib/perl5:${OPT}/perl5/lib/perl5/x86_64-linux-thread-multi"
set -f path=("${OPT}/perl5/bin" $path:q)

# Docbook-xsl
source ${OPT}/docbook-xsl-1.79.1/.cshrc.incl
