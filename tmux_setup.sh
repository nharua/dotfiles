#!/bin/bash
echo "Setup tmux environment to local user profile ..."

# dotfiles directory
#dotfilesDir="${HOME}/myWork/dotfiles"
dotfilesDir="$(pwd)"

# check file exist
tmuxfile="${HOME}/.tmux.conf "
if [ -d "${tmuxfile}" ]; then
    # backup old file
    mv "${tmuxfile}" "${tmuxfile}.bck"
fi

# check folder exist
tmuxfolder="${HOME}/.tmux"
if [ -d "${tmuxfolder}" ]; then
    # backup old directory
    mv "${tmuxfolder}" "${tmuxfolder}.bck"
fi

ln -sf "${dotfilesDir}/.tmux" "${HOME}"
ln -sf "${dotfilesDir}/.tmux.conf" "${HOME}"

echo "Setup tmux successfully."
