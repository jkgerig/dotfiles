# bash_profile

# source bashrc
source "${HOME}/.bashrc"

# Set PATH to include private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# source local file if it exists
if [ -r "${HOME}/.bash_profile.local" ] ; then
    . "${HOME}/.bash_profile.local"
fi
_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
