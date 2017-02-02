# Start the terminal multiplexer when not running screen.
[[ -z $TMUX ]] && [[ ! $TERM =~ screen-256color ]] && [[ -f /bin/tmux ]] && exec tmux

# Include the users' bashrc if running interactively.
if [[ $- == *i* && -r "${HOME}/.bashrc" ]]; then
   source "${HOME}/.bashrc"
fi

