#!/bin/bash
set -eu

brew bundle dump --force
cp ~/.vimrc .vimrc
cp ~/.zshrc .zshrc
