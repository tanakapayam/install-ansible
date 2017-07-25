# ansible-playbook lock
# https://stackoverflow.com/a/21872329
ansible-playbook() {
  lock="/tmp/ansible-playbook.lock"

  # Check if lock exists, return if yes
  if [ -e $lock ]; then
    echo "Sorry, someone is running already ansible from `cat $lock`"
    return
  fi

  # Install signal handlers
  trap "rm -f $lockfile; trap - INT TERM EXIT; return" INT TERM EXIT

  # Create lock file, saving originating IP
  echo $SSH_CLIENT | cut -f1 -d' ' > $lock

  # Run ansible with arguments passed at the command line
  `which ansible-playbook` "$@"

  # Remove lock file
  rm $lock

  # Remove signal handlers
  trap - INT TERM EXIT
}


# The End
the_end() {
  echo "${BOLD}${GREEN}The End${RESET}"
  echo

  exit 0
}
