#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# bashrc
[ -d "${BASEDIR}/.bashrc" ] && rm -r "${BASEDIR}/.bashrc"
ln -vs ${BASEDIR}/.dotfiles/bash/.bashrc ${BASEDIR}/.bashrc

# vim
[ -d "${BASEDIR}/.vimrc" ] && rm -r "${BASEDIR}/.vimrc"
ln -vs ${BASEDIR}/.dotfiles/vim/.vimrc ${BASEDIR}/.vimrc
[ -d "${BASEDIR}/.vim" ] && rm -r "${BASEDIR}/.vim"
ln -vs ${BASEDIR}/.dotfiles/vim/.vim ${BASEDIR}/.vim

# doom
# Remeber: 
# 1. Install emacs
# 2. clone doom repository 
# 3. doom install 
# link files here
[ -d "${BASEDIR}/.doom.d" ] && rm -r "${BASEDIR}/.doom.d"
ln -vs ${BASEDIR}/.dotfiles/doom/.doom.d ${BASEDIR}/.doom.d

# git
[ -d "${BASEDIR}/.gitconfig" ] && rm -r "${BASEDIR}/.gitconfig"
ln -vs ${BASEDIR}/.dotfiles/git/.gitconfig ${BASEDIR}/.gitconfig
