# Extend the path.
export PATH="${HOME}/.bin:${PATH}"

# Include the users' bashrc if running interactively.
if [[ $- == *i* && -r "${HOME}/.bashrc" ]]; then
   source "${HOME}/.bashrc"
fi

