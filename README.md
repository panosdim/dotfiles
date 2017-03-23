# My dotfiles
Store dot files used in my unix/linux computers.

## Installation
In order to install use the install.sh script. You can install one, some or all dotfiles
```
$ git clone --recursive https://github.com/panosdim/dotfiles.git
$ cd dotfiles
$ ./install.sh -h

Usage: ./install.sh options

This install dotfiles in your home directory.

OPTIONS:
 -h      Show this message
 -b      Install bash dotfiles
 -z      Install zsh dotfiles
 -c      Install tcsh/csh dotfiles
 -v      Install vim dotfiles
 -m      Install mrxvt dotfiles
 -f      Install fish dotfiles
 -a      Install all dotfiles 

$ ./install.sh -a
```
