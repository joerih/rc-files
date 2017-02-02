# Start the terminal multiplexer when not running in Screen and when not running in Visual Studio Code.
if [[ -z $TMUX ]] && [[ ! $TERM =~ screen-256color ]] && [[ ! $TERM_PROGRAM =~ vscode ]] && [[ -f /usr/bin/tmux ]]; then
   exec tmux
fi

# Include the users' bashrc if running interactively.
if [[ $- == *i* && -r "${HOME}/.bashrc" ]]; then
   source "${HOME}/.bashrc"
fi

