#!/bin/bash

ln -s -T "${HOME}/.vim/dotfiles/bashrc"  "${HOME}/.bashrc"
ln -s -T "${HOME}/.vim/dotfiles/inputrc" "${HOME}/.inputrc"
ln -s -T "${HOME}/.vim/dotfiles/haskeline" "${HOME}/.haskeline"

mkdir -p "${HOME}/.ghc/"
ln -s -T "${HOME}/.vim/dotfiles/ghc/ghci.conf" "${HOME}/.ghc/ghci.conf"

ln -s -T "${HOME}/.vim/dotfiles/config/mpv" "${HOME}/.config/mpv"
ln -s -T "${HOME}/.vim/dotfiles/config/streamlink" "${HOME}/.config/streamlink"
