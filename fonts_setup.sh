#!/bin/bash
echo "Install new fonts to local user profile ..."

# dotfiles directory
#dotfilesDir="${HOME}/myWork/dotfiles"
dotfilesDir="$(pwd)"

# check folder exist
fontfolder="${HOME}/.local/share/fonts"
if [ -d "${fontfolder}" ]; then
    # backup old directory
    mv "${fontfolder}" "${fontfolder}.bck"
fi

ln -sf "${dotfilesDir}/.local/share/fonts" "${HOME}/.local/share"

echo "Install new fonts successfully."
