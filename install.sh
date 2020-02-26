#!/bin/bash

# setup dotfiles by symlinking relevant files and dirs

# 1. cd to HOME
# 2. create .oldrc dir
# 3. move all relevant files to .oldrc/
# 4. symlink all files
#
# NOTE: go ahead and make ${HOME}/.config/nvim without checking
# to see if neovim is installed because I'm lazy

# NOTE: prompt before most things, I haven't looked at this in years
# and forget how everything works

cd $HOME

if [ ! -d ".oldrc/" ]; then
    mkdir .oldrc/
fi

mv -i -t .oldrc/ \
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
ln -s ${HOME}/.dotfiles/gitconfig .gitconfig
ln -s ${HOME}/.dotfiles/inputrc .inputrc
ln -s ${HOME}/.dotfiles/tmux.conf .tmux.conf
ln -s ${HOME}/.dotfiles/vimrc .vimrc

mv -i ${HOME}/.config/nvim/init.vim ${HOME}/.oldrc/

if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir ${HOME}/.config/nvim
fi

ln -s ${HOME}/.dotfiles/init.vim ${HOME}/.config/nvim/init.vim
