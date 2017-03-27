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
 -b      Install bash dotfiles
 -z      Install zsh dotfiles
 -c      Install tcsh/csh dotfiles
 -v      Install vim dotfiles
 -m      Install mrxvt dotfiles
 -f      Install fish dotfiles
 -a      Install all dotfiles 

EOF
}

# Check if provided any argument
if [ $# -eq 0 ]; then
    usage
    exit
fi

# Check if rsync is available
command -v rsync >/dev/null && continue || { echo "rsync command not found. Please install rsync program."; exit 1; }

# Change to script directory
cd "$(dirname "${BASH_SOURCE}")"

# Check input parameters and options
while getopts "hbzcvmfa" optname
 do
	 case "$optname" in
	   "h")
	     usage
	     exit
	     ;;
	   "b")
	     rsync -avh --no-perms bash/ ~
	     ;;
	   "z")
	     rsync -avh --no-perms zsh/ ~
	     ;;
	   "c")
	     rsync -avh --no-perms tcsh/ ~
	     ;;
	   "v")
	     rsync -avh --no-perms vim/ ~
	     ;;
	   "m")
	     rsync -avh --no-perms mrxvt/ ~
	     ;;
	   "f")
	     rsync -avh --no-perms fish/ ~
	     ;;
	   "a")
	     rsync -avh --no-perms bash/ ~
	     rsync -avh --no-perms zsh/ ~
	     rsync -avh --no-perms tcsh/ ~
	     rsync -avh --no-perms vim/ ~
	     rsync -avh --no-perms mrxvt/ ~
	     rsync -avh --no-perms fish/ ~
	     ;;
	   "?")
       usage
       exit
       ;;
	 esac
 done
