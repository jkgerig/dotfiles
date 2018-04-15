# bash_profile

# Set PATH to include private bin(s) if it (they) exist(s)
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

if [ -d "${HOME}/.bin" ] ; then
    PATH="${HOME}/.bin:$PATH"
fi

if [ -d "${HOME}/.local/bin" ] ; then
    PATH="${HOME}/.local/bin:$PATH"
fi

source "${HOME}/.bash_profile.local"

# source bashrc
# should I be using "source" or "." here?
source "${HOME}/.bashrc"

