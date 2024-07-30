#!/bin/bash
echo "Setup bash shell profiles on ..."

# dotfiles directory
#dotfilesDir="${HOME}/myWork/dotfiles"
dotfilesDir="$(pwd)"

# list of files/folders to symlink in ${HOME}
files=(bashrc bash_profile Xdefaults)

# change to the dotfiles directory
echo "Changing to the ${dotfilesDir} directory"
cd "${dotfilesDir}" || exit

# Check if the file exists, backup these files
for file in "${files[@]}"; do
    if [ -f "${HOME}/.${file}" ]; then
       # Rename the .bak
       mv "${HOME}/.${file}" "${HOME}/.${file}.bak"
    fi
done

# create symlinks (will overwrite old dotfiles)
for file in "${files[@]}"; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${dotfilesDir}/.${file}" "${HOME}/.${file}"
done

# check folder exist
gitfolder="${HOME}/.config/git-url-swizzler"
if [ -d "${gitfolder}" ]; then
    # backup old directory
    mv "${gitfolder}" "${gitfolder}.bck"
fi

# If not, create the folder
mkdir -p "${gitfolder}"
echo "Folder created at $gitfolder"

ln -sf "${dotfilesDir}/.config/git-url-swizzler/git-completion.bash" "${gitfolder}/git-completion.bash"
ln -sf "${dotfilesDir}/.config/git-url-swizzler/git-prompt.sh" "${gitfolder}/git-prompt.sh"

echo "Setup bash profile successfully."
