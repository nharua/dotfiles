#!/bin/bash

echo "SSH keygen..."
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N ""

echo "SSH key generated successfully."
echo "Please manually add the following public key to your GitLab account:"
cat ~/.ssh/id_ed25519.pub

echo "Once added, press Enter to continue..."
read

echo "Copying SSH key to localhost..."
ssh-copy-id localhost
echo "SSH key copied successfully."
