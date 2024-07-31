#!/bin/bash
echo "Setup emacs environment to local user profile ..."

# dotfiles directory
#dotfilesDir="${HOME}/myWork/dotfiles"
dotfilesDir="$(pwd)"

# check file exist
emacsfile="${HOME}/.emacs"
if [ -d "${emacsfile}" ]; then
    # backup old file
    mv "${emacsfile}" "${emacsfile}.bck"
fi

# check folder exist
emacsfolder="${HOME}/.emacs.d"
if [ -d "${emacsfolder}" ]; then
    # backup old directory
    mv "${emacsfolder}" "${emacsfolder}.bck"
fi

ln -sf "${dotfilesDir}/.emacs.d" "${HOME}"

echo "Setup emacs successfully."
