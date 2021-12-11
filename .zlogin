# Start the terminal multiplexer when not running screen.
[[ -z $TMUX ]] && [[ ! $TERM =~ screen-256color ]] && [[ -f /usr/local/bin/tmux ]] && exec tmux

