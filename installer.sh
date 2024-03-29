#!/bin/bash

#BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#echo $BASH_SHOURCE[0]
#echo $BASH_SHOURCE
#echo $BASEDIR
#echo $(pwd)
BASEDIR=$(pwd)
# If using pwd as the BASEDIR, then this file should be run from
# the $HOME path

# bashrc
[ -f "${BASEDIR}/.bashrc" ] && rm "${BASEDIR}/.bashrc"
ln -vs ${BASEDIR}/.dotfiles/bash/.bashrc ${BASEDIR}/.bashrc

# vim
[ -f "${BASEDIR}/.vimrc" ] && rm "${BASEDIR}/.vimrc"
ln -vs ${BASEDIR}/.dotfiles/vim/.vimrc ${BASEDIR}/.vimrc
[ -d "${BASEDIR}/.vim" ] && rm -r "${BASEDIR}/.vim"
ln -vs ${BASEDIR}/.dotfiles/vim/.vim ${BASEDIR}/.vim

# doom
# Remeber: 
# 1. Install emacs
# 2. clone doom repository 
# 3. doom install 
# link files here
#[ -d "${BASEDIR}/.config/.doom.d" ] && rm -r "${BASEDIR}/.config/.doom.d"
#ln -vs ${BASEDIR}/.dotfiles/doom/.doom.d ${BASEDIR}/.config/.doom.d
[ -d "${BASEDIR}/.config/doom" ] && rm -r "${BASEDIR}/.config/doom"
ln -vs ${BASEDIR}/.dotfiles/doom/.doom.d ${BASEDIR}/.config/doom

# git
[ -f "${BASEDIR}/.gitconfig" ] && rm "${BASEDIR}/.gitconfig"
ln -vs ${BASEDIR}/.dotfiles/git/.gitconfig ${BASEDIR}/.gitconfig
