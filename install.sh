#!/bin/bash

set -e

# Mappen dette skriptet ligger i, så repoet kan ligge hvor som helst
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

echo "Setter opp dotfiles fra $DOTFILES..."

# Husk git-identiteten før .gitconfig overskrives
GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

# kilde (i repoet) -> mål (i hjemmemappen)
FILES=(
  "zsh/.zshrc:$HOME/.zshrc"
  "zsh/.p10k.zsh:$HOME/.p10k.zsh"
  "git/.gitconfig:$HOME/.gitconfig"
  "kitty/kitty.conf:$HOME/.config/kitty/kitty.conf"
  "kitty/colors/cherry_blossom.conf:$HOME/.config/kitty/colors/cherry_blossom.conf"
  "nvim/init.lua:$HOME/.config/nvim/init.lua"
)

for entry in "${FILES[@]}"; do
  src="$DOTFILES/${entry%%:*}"
  dest="${entry#*:}"

  # Ta backup av eksisterende fil hvis den er ulik den nye
  if [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
    mkdir -p "$BACKUP"
    cp "$dest" "$BACKUP/"
    echo "  backup: $dest -> $BACKUP/"
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
done

# Legg git-identiteten tilbake, eller spør om den
if [ -z "$GIT_NAME" ]; then
  read -rp "Git-navn (for commits): " GIT_NAME
fi
if [ -z "$GIT_EMAIL" ]; then
  read -rp "Git-e-post (for commits): " GIT_EMAIL
fi
if [ -n "$GIT_NAME" ]; then git config --global user.name "$GIT_NAME"; fi
if [ -n "$GIT_EMAIL" ]; then git config --global user.email "$GIT_EMAIL"; fi

echo "Ferdig!"
if [ -d "$BACKUP" ]; then echo "Gamle filer ligger i $BACKUP"; fi
echo "Kjør: exec zsh"
