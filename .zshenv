# Import all env scripts from the .zsh folder.
for file in ~/.zsh/env-*; do
   [[ ! ${file} =~ ^.*\.example$ ]] && source ${file}
done
