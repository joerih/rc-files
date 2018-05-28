# Start the terminal multiplexer when not running screen.
[[ -z $TMUX ]] && [[ -z $VSCODE ]] && [[ ! $TERM =~ screen-256color ]] && [[ -f /usr/bin/tmux ]] && exec tmux

# Include the users' bashrc if running interactively.
if [[ $- == *i* && -r "${HOME}/.bashrc" ]]; then
   source "${HOME}/.bashrc"
fi

