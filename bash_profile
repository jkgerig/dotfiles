# bash_profile

# Set PATH to include private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# source local file if it exists
if [ -r "${HOME}/.bash_profile.local" ] ; then
    . "${HOME}/.bash_profile.local"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# source bashrc
source "${HOME}/.bashrc"
