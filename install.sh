#!/bin/bash

set -e

echo "Setter opp dotfiles..."

mkdir -p ~/.config/kitty/colors
mkdir -p ~/.config/nvim

cp ~/dotfiles/zsh/.zshrc ~/.zshrc
cp ~/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
cp ~/dotfiles/git/.gitconfig ~/.gitconfig
cp ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
cp ~/dotfiles/kitty/colors/cherry_blossom.conf ~/.config/kitty/colors/cherry_blossom.conf
cp ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua

echo "Ferdig!"
echo "Kjør: source ~/.zshrc"
