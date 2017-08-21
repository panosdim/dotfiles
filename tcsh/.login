#!/usr/bin/env csh

# General settings
setenv OPT ${HOME}/opt
set -f path=("${OPT}/bin" $path:q)
if ( "`echo $LD_LIBRARY_PATH | grep -v ${OPT}/lib`" != "" ) setenv LD_LIBRARY_PATH ${OPT}/lib:${LD_LIBRARY_PATH}
if ( "`echo $MANPATH | grep -v ${OPT}/man`" != "" ) setenv MANPATH ${OPT}/man:${MANPATH}
if ( "`echo $MANPATH | grep -v ${OPT}/share/man`" != "" ) setenv MANPATH ${OPT}/share/man:${MANPATH}
if ( "`echo $PKG_CONFIG_PATH | grep -v ${OPT}/lib/pkgconfig`" != "" ) setenv PKG_CONFIG_PATH ${OPT}/lib/pkgconfig:${PKG_CONFIG_PATH}
if ( "`echo $XDG_DATA_DIRS | grep -v ${OPT}/share`" != "" ) setenv XDG_DATA_DIRS ${OPT}/share:${XDG_DATA_DIRS}
setenv CPATH ${OPT}/include
setenv GSETTINGS_SCHEMA_DIR ${OPT}/share/glib-2.0/schemas
setenv MAN_POSIXLY_CORRECT 1

# Set Java
set -f path=("${OPT}/jdk/bin" $path:q)
setenv MANPATH ${OPT}/jdk/man:${MANPATH}
setenv CLASSPATH ${OPT}/jdk/jre/lib:${OPT}/jdk/lib
setenv JAVA_HOME ${OPT}/jdk
setenv JAVA_BINDIR ${OPT}/jdk/bin 
setenv JAVA_ROOT ${OPT}/jdk 
setenv JRE_HOME ${OPT}/jdk/jre 
setenv JDK_HOME ${OPT}/jdk 
setenv SDK_HOME ${OPT}/jdk 

# Set LANG
setenv LANG en_US.utf8

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
