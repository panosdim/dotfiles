#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# install.sh -- Install dotfiles
#
# Copyright 2013 Panagiotis Dimopoulos (panosdim@gmail.com)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at (http://www.gnu.org/licenses/) for
# more details.
#
# Version: 1.0
# ---------------------------------------------------------------------------

# Function that printout the correct usage of the script
usage()
{
cat << EOF

Usage: $0 options

This install dotfiles in your home directory.

OPTIONS:
 -h      Show this message
 -a      Install ash dotfiles
 -b      Install bash dotfiles
 -v      Install vim dotfiles
 -f      Install fish dotfiles

EOF
}

# Check if provided any argument
if [ $# -eq 0 ]; then
    usage
    exit
fi

# Check if rsync is available
command -v rsync >/dev/null || { echo "rsync command not found. Please install rsync program."; exit 1; }

# Change to script directory
cd "$(dirname "${BASH_SOURCE}")" || exit 1

# Check input parameters and options
while getopts "hbvfa" optname
 do
	 case "$optname" in
	   "h")
	     usage
	     exit
	     ;;
	   "b")
	     rsync -avh --no-perms bash/ ~
	     ;;
	   "v")
	     curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	     rsync -avh --no-perms vim/ ~
	     ;;
	   "f")
	     rsync -avh --no-perms fish/ ~
	     ;;
	   "a")
	     rsync -avh --no-perms ash/ ~
		 ;;
	   "?")
       usage
       exit
       ;;
	 esac
 done
