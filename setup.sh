#!/bin/bash
set -eu

echo '===== add .zshrc ====='
ZSHRC=~/.zshrc
if [ -f "$ZSHRC" ]; then
  echo "$ZSHRC exists."
else
  ORIGINAL_ZSHRC=`readlink -f .zshrc`
  cp "$ORIGINAL_ZSHRC" "$ZSHRC"
fi

echo '===== add .vimrc ====='
VIMRC=~/.vimrc
if [ -f "$VIMRC" ]; then
  echo "$VIMRC exists."
else
  ORIGINAL_VIMRC=`readlink -f .vimrc`
  cp "$ORIGINAL_VIMRC" "$VIMRC"
fi
mkdir -p ~/tmp/vim

echo '===== install packages ====='
brew bundle

cd ~

echo '===== install z command ====='
ZSHD=.zsh.d
if [ -d "$ZSHD" ]; then
  echo "$ZSHD exists."
else
  git clone https://github.com/rupa/z.git
  mv z "$ZSHD"
fi

echo '===== install vim plug ====='
if [ -f ".vim/autoload/plug.vim" ]; then
  echo "vim plug exists."
else
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
