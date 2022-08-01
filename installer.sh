#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# emacs
ln -vs ${BASEDIR}/bash/.bashrc ~/.bashrc

# vim
ln -vs ${BASEDIR}/vim/.vimrc ~/.vimrc
ln -vs ${BASEDIR}/vim/.vim ~/.vim

# emacs
ln -vs ${BASEDIR}/emacs/.emacs.d ~/.emacs.d

# doom
ln -vs ${BASEDIR}/doom/.doom.d ~/.doom.d
