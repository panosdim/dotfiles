# Function to generate prompt
__prompt_command() {
  local EXIT="$?"
  PS1=""

  # Change color for root or regular user
  if [ "$HOME" = "/root" ]; then
    PS1="${PS1}\033[48;5;202m ${USER:-root} \033[m"
  else
    # Check if we can sudo (simplified check for busybox)
    if [ -f /usr/bin/sudo ] && sudo -n true 2>/dev/null; then
      PS1="${PS1}\033[48;5;202m ${USER:-user} \033[m"
    else
      PS1="${PS1}\033[48;5;32m ${USER:-user} \033[m"
    fi
  fi

  # Add hostname if we're in SSH session
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="${PS1}\033[48;5;34m \$(cat /proc/sys/kernel/hostname 2>/dev/null || echo 'router') \033[m"
  fi

  # Add working directory and exit status
  PS1="${PS1}\033[48;5;240m \$(pwd) \033[m\033[48;5;52m\$([ $EXIT -ne 0 ] && echo $EXIT)\033[m "
}

# Set up the prompt
__prompt_command
export PS1
