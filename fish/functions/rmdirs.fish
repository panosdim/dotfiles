#
# Remove all dirs in current folder
#
function rmdirs --description "Remove all directories in current directory"
	command rm -rf (ls -1 -d */)
end
