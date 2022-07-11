# Start the terminal multiplexer when not running in Screen and when not running in Visual Studio Code.
if [[ -z $TMUX ]] && [[ ! $TERM =~ screen-256color ]] && ! pstree -p $$ | grep -q "Visual Studio Code\.app" && [[ -f /usr/local/bin/tmux ]]; then
   exec tmux
fi
