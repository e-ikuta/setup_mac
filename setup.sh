#!/bin/bash
set -eu

echo '===== add .zshrc ====='
ZSHRC=~/.zshrc
if test -f "$ZSHRC"; then
  echo "$ZSHRC exists."
else
  ORIGINAL_ZSHRC=`readlink -f .zshrc`
  ln -s "$ORIGINAL_ZSHRC" "$ZSHRC"
fi

echo '===== add .vimrc ====='
VIMRC=~/.vimrc
if test -f "$VIMRC"; then
  echo "$VIMRC exists."
else
  ORIGINAL_VIMRC=`readlink -f .vimrc`
  ln -s "$ORIGINAL_VIMRC" "$VIMRC"
fi

echo '===== install packages ====='
brew bundle

echo '===== install z command ====='
cd ~
git clone git@github.com:rupa/z.git
mv z .zsh.d

echo '===== install vim plug ====='
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
