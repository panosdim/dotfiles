#
# Delete an offending key in known_hosts files
#
function delkey --description "Delete an offending key"
	command sed -i -e "$argv"d /home/xigpadi/.ssh/known_hosts
end
