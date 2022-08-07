#!/bin/bash
set -eux

####################
# install packages
####################
brew bundle

##################
# z command
##################
cd ~
git clone git@github.com:rupa/z.git
mv z .zsh.d

##################
# vim plug
##################
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
