#!/bin/bash

# Script to download (wget or git-clone) my vim plugins to a LOCAL
# directory rather than including vim plugins in my dotfiles repo.

# If ~/.vim/ does NOT exist, create it.
if [ ! -d ~/.vim ] ; then
    mkdir ~/.vim
else
    echo '~/.vim already exists, skipping.'
fi

# If ~/.vim/autoload does NOT exist, create it.
if [ ! -d ~/.vim/autoload ] ; then
    mkdir ~/.vim/autoload
else
    echo '~/.vim/autoload already exists, skipping.'
fi

# If ~/.vim/bundle does NOT exist, create it.
if [ ! -d ~/.vim/bundle ] ; then
    mkdir ~/.vim/bundle
else
    echo '~/.vim/bundle already exists, skipping.'
fi

# If ~/.vim/undo does NOT exist, create it.
if [ ! -d ~/.vim/undo ] ; then
    mkdir ~/.vim/undo
else
    echo '~/.vim/undo already exists, skipping.'
fi

# If ~/.vim/autoload/pathogen.vim does NOT exist, download it:
if [ ! -f ~/.vim/autoload/pathogen.vim ] ; then
    echo 'Downloading pathogen.vim...'
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
    echo '~/.vim/autoload/pathogen.vim already exists, skipping.'
fi

# for each github repo in vim-plugins-list.txt do:
#   assign repo and plugin_dir variables:
for repo in `cat vim-plugins-list.txt`; do
    plugin_dir=$(echo $repo | \
        sed -r -e 's/.+\.com.([^\/]+\/)/\1/' \
        -e 's/\//_/' \
        -e 's/\.git//')
    # if plugin_dir does NOT exist, trigger git clone
    if [ ! -d ~/.vim/bundle/${plugin_dir} ] ; then
        git clone $repo ~/.vim/bundle/${plugin_dir}
    else
        echo "~/.vim/bundle/${plugin_dir} already exists, skipping."
    fi
done
