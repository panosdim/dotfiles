function fd --description "Find files and folders that are large"
    if count $argv > /dev/null
        command du -hs --exclude=.snapshot "$argv"/* | sort -rh | head -10
    else
        command du -hs --exclude=.snapshot * | sort -rh | head -10
    end
end

