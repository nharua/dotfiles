#!/bin/bash

echo "Setting up gitconfig..."
read -p "Enter your name: " name
read -p "Enter your email: " email

git config --global user.name "$name"
git config --global user.email "$email"

git config --global merge.tool meld
git config --global mergetool.prompt false
git config --global diff.tool meld
git config --global mergetool.keepBackup false
git config --global core.autocrlf true
# git config --global alias.tree "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
git config --global alias.tree "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"

echo "Gitconfig setup completed."
