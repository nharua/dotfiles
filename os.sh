#!/bin/bash

# check update and upgrade the os
sudo dnf check-update
sudo dnf upgrade -y

# Install some package that will need for work
sudo dnf install -y git gcc make cmake pkgconfig unzip curl doxygen gettext curl git libtool autoconf automake gperf lua-devel luajit-devel
sudo dnf install compat-lua-libs libtermkey libtree-sitter libvterm luajit luajit2.1-luv msgpack unibilium xsel
