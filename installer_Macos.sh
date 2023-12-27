#!/bin/zsh

# this script shoud be execute where the original config files are located
BASEDIR=$(pwd)

# bashrc
[ -f "${BASEDIR}/.bashrc" ] && rm "${BASEDIR}/.bashrc" 
ln -vs ${BASEDIR}/.dotfiles/bash/.bashrc ${BASEDIR}/.bashrc

# zshrc
[ -f "${BASEDIR}/.zshrc" ] && rm "${BASEDIR}/.zshrc" 
ln -vs ${BASEDIR}/.dotfiles/zsh/.zshrc ${BASEDIR}/.zshrc
[ -f "${BASEDIR}/.zprofile" ] && rm "${BASEDIR}/.zprofile" 
ln -vs ${BASEDIR}/.dotfiles/zsh/.zprofile ${BASEDIR}/.zprofile

# vim
[ -f "${BASEDIR}/.vimrc" ] && rm "${BASEDIR}/.vimrc" 
ln -vs ${BASEDIR}/.dotfiles/vim/.vimrc ${BASEDIR}/.vimrc
[ -d "${BASEDIR}/.vim" ] && rm -r "${BASEDIR}/.vim" 
ln -vs ${BASEDIR}/.dotfiles/vim/.vim ${BASEDIR}/.vim

# doom
# Remember: 
# 1. Install emacs
# 2. clone doom repository 
# 3. doom install 
# link files here
[ -d "${BASEDIR}/.config/doom" ] && rm -r "${BASEDIR}/.config/doom" 
ln -vs ${BASEDIR}/.dotfiles/doom/.doom.d ${BASEDIR}/.config/doom

# git
[ -f "${BASEDIR}/.gitconfig" ] && rm "${BASEDIR}/.gitconfig" 
ln -vs ${BASEDIR}/.dotfiles/git/.gitconfig ${BASEDIR}/.gitconfig
