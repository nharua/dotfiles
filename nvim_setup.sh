#!/bin/bash
echo "Setup nvim environment to local user profile ..."

# dotfiles directory
#dotfilesDir="${HOME}/myWork/dotfiles"
dotfilesDir="$(pwd)"

# check folder config exist
nvimconfigfolder="${HOME}/.config/nvim"
if [ -d "${nvimconfigfolder}" ]; then
    # backup old file
    mv "${nvimconfigfolder}" "${nvimconfigfolder}.bck"
fi

# check folder lib exist
nvimlibfolder="${HOME}/.local/share/nvim"
if [ -d "${nvimlibfolder}" ]; then
    # backup old directory
    mv "${nvimlibfolder}" "${nvimlibfolder}.bck"
fi

ln -sf "${dotfilesDir}/.config/nvim" "${HOME}/.config/"
# comment out if you're on secure zone
# ln -sf "${dotfilesDir}/.local/share/nvim" "${HOME}/.local/share"

# check bin not folder exist
# nvimbinfolder="${HOME}/.local/bin"
# if [ ! -d "${nvimbinfolder}" ]; then
#     # create bin folder
#     mkdir -p "${nvimbinfolder}"
# fi

# ln -sf "${dotfilesDir}/.local/nvim-0.9.5" "${HOME}/.local"
# ln -sf "../nvim-0.9.5/bin/nvim" "${HOME}/.local/bin/nvim"
echo "Setup nvim successfully."
