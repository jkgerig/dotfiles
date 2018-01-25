#!/bin/bash

# setup dotfiles by symlinking relevant files and dirs

# 1. cd to HOME
# 2. create .oldrc dir
# 3. move all relevant files to .oldrc/
# 4. symlink all files
#
# NOTE: go ahead and make ${HOME}/.config/nvim without checking
# to see if neovim is installed because I'm lazy

cd $HOME

mkdir .oldrc

mv -t .oldrc/ \
    .bash_aliases \
    .bash_profile \
    .bashrc \
    .dircolors \
    .git-prompt.sh \
    .gitconfig \
    .inputrc \
    .tmux.conf \
    .vimrc \

ln -s ${HOME}/.dotfiles/bash_aliases .bash_aliases
ln -s ${HOME}/.dotfiles/bash_profile .bash_profile
ln -s ${HOME}/.dotfiles/bashrc .bashrc
ln -s ${HOME}/.dotfiles/dircolors .dircolors
ln -s ${HOME}/.dotfiles/git-prompt.sh .git-prompt.sh
ln -s ${HOME}/.dotfiles/gitconfig .gitconfig
ln -s ${HOME}/.dotfiles/inputrc .inputrc
ln -s ${HOME}/.dotfiles/tmux.conf .tmux.conf
ln -s ${HOME}/.dotfiles/vimrc .vimrc

mv ${HOME}/.config/nvim/init.vim ${HOME}/.oldrc/
mkdir -p ${HOME}/.config/nvim
ln -s ${HOME}/.dotfiles/init.vim ${HOME}/.config/nvim/init.vim
