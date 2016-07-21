# bash_profile

# source bashrc
source "${HOME}/.bashrc"

# Set PATH to include private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

