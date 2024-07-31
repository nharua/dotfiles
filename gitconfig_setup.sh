#!/bin/bash

echo "Setting up gitconfig..."
read -p "Enter your name: " name
read -p "Enter your email: " email

git config --global user.name "$name"
git config --global user.email "$email"

echo "Gitconfig setup completed."
