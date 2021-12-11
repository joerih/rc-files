# Import all rc scripts from the .zsh folder.
for file in ~/.zsh/rc-*; do
   [[ ! ${file} =~ ^.*\.example$ ]] && source ${file}
done
