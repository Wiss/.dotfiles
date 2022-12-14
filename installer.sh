#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# bashrc
ln -vs ${BASEDIR}/.dotfiles/bash/.bashrc ${BASEDIR}/.bashrc

# vim
ln -vs ${BASEDIR}/.dotfiles/vim/.vimrc ${BASEDIR}/.vimrc
ln -vs ${BASEDIR}/.dotfiles/vim/.vim ${BASEDIR}/.vim

# doom
# Remeber: 
# 1. Install emacs
# 2. clone doom repository 
# 3. doom install 
# link files here
ln -vs ${BASEDIR}/.dotfiles/doom/.doom.d ${BASEDIR}/.doom.d

# git
ln -vs ${BASEDIR}/.dotfiles/git/.gitconfig ${BASEDIR}/.gitconfig
