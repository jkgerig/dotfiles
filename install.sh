#!/bin/bash

# setup dotfiles by symlinking relevant files and dirs

# 1. cd to HOME
# 2. create .oldrc dir
# 3. move all relevant files and dirs to .oldrc/
# 4. symlink all files

cd

mkdir .oldrc

mv -t .oldrc/ \
    .bin/ \
    .lib/ \
    .bash_aliases \
    .bash_logout \
    .bash_profile \
    .bashrc \
    .dircolors \
    .gitconfig \
    .git-prompt.sh \
    .inputrc \
    .tmux.conf \
    .tmux.f-keys.disable \
    .tmux.f-keys.enable \
    .vimrc \
    .Xresources

ln -s .dotfiles/bin .bin
ln -s .dotfiles/lib .lib
ln -s .dotfiles/bash_aliases .bash_aliases
ln -s .dotfiles/bash_logout .bash_logout
ln -s .dotfiles/bash_profile .bash_profile
ln -s .dotfiles/bashrc .bashrc
ln -s .dotfiles/dircolors .dircolors
ln -s .dotfiles/gitconfig .gitconfig
ln -s .dotfiles/git-sh-prompt .git-prompt.sh
ln -s .dotfiles/inputrc .inputrc
ln -s .dotfiles/tmux.conf .tmux.conf
ln -s .dotfiles/tmux.f-keys.disable .tmux.f-keys.disable
ln -s .dotfiles/tmux.f-keys.enable .tmux.f-keys.enable
ln -s .dotfiles/vimrc .vimrc
ln -s .dotfiles/Xresources .Xresources

