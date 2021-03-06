function fish_prompt --description 'Write out the prompt' 
  set -l last_status $status
  
  # User 
  if test "$HOME" = "/root"
      set_color -b red
  else
      if sudo -n uptime ^&1 | grep -q "load"
          set_color -b red
      else
          echo -n "[38;5;250m[48;5;240m"
      end
  end
  echo -n " "
  echo -n (whoami)
  echo -n " "
  
  # Host 
  echo -n "[38;5;124m[48;5;202m " 
  echo -n (prompt_hostname)
  echo -n " " 
  
  # PWD 
  echo -n "[38;5;15m[48;5;31m "  
  echo -n (prompt_pwd)
  echo -n " "
  
  # Last command status
  if not test $last_status -eq 0 
    echo -n "[38;5;15m[48;5;161m "
    echo -n $last_status
    echo -n " "
  end
 
  # User symbol
  set -l prompt_symbol '' 
  switch $USER 
    case root; set prompt_symbol '#' 
    case '*'; set prompt_symbol '$' 
  end 
  
  echo -n "[38;5;15m[48;5;104m "
  echo -n $prompt_symbol
  echo -n " "
  set_color normal 
end
