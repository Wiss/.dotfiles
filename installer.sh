#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# bashrc
ln -vs ${BASEDIR}/bash/.bashrc ~/.bashrc

# vim
ln -vs ${BASEDIR}/vim/.vimrc ~/.vimrc
ln -vs ${BASEDIR}/vim/.vim ~/.vim

# doom
ln -vs ${BASEDIR}/doom/.doom.d ~/.doom.d

# git
ln -vs ${BASEDIR}/git/.gitconfig ~/.gitconfig
