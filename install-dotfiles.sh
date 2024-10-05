#!/bin/bash

ln -s "${HOME}/.vim/dotfiles/bashrc"  "${HOME}/.bashrc"
ln -s "${HOME}/.vim/dotfiles/inputrc" "${HOME}/.inputrc"
ln -s "${HOME}/.vim/dotfiles/haskeline" "${HOME}/.haskeline"

mkdir -p "${HOME}/.ghc/"
ln -s "${HOME}/.vim/dotfiles/ghc/ghci.conf" "${HOME}/.ghc/ghci.conf"
ln -s "${HOME}/.vim/dotfiles/ghc/Morj_Ghci_Prompt.hs" "${HOME}/.ghc/Morj_Ghci_Prompt.hs"

ln -s "${HOME}/.vim/dotfiles/config/mpv" "${HOME}/.config/mpv"
ln -s "${HOME}/.vim/dotfiles/config/streamlink" "${HOME}/.config/streamlink"

mkdir -p "${HOME}/.config/fish"
ln -s "${HOME}/.vim/dotfiles/config/fish/config.fish" "${HOME}/.config/fish/config.fish"
