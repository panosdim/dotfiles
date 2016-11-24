function dk --description "Delete some offending keys from $HOME/.ssh/known_hosts file"
    if count $argv > /dev/null
        for i in $argv
            command sed -i -e "$i"d /$HOME/.ssh/known_hosts
        end
    end
end

