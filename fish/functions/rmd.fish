function rmd --description "Remove all directories in current directory"
    command rm -rf (ls -1 -d */)
end
