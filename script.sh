#!/bin/bash

####################
# install packages
####################
brew install \
  vim \
  nodenv \
  rbenv \
  zsh-syntax-highlighting \
  zsh-autosuggestions \

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

##################
# nerdtree
##################
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
# set terminal text to 'HacK Nerd Font'
