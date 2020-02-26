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

if [ -f "${HOME}/.bash_profile.local" ] ; then
    source "${HOME}/.bash_profile.local"
fi

# source bashrc
# should I be using "source" or "." here?
source "${HOME}/.bashrc"


