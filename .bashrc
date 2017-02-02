# If not running interactively, don't do anything.
[[ "$-" != *i* ]] && return

# Import all scripts from the .bash folder.
for file in ~/.bash/*; do
   [[ ! ${file} =~ ^.*\.sample$ ]] && source ${file}
done

