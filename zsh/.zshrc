# .zshrc

#######################################################################################################################
# Powerlevel10k instant prompt                                                                                        #
#######################################################################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#######################################################################################################################
# Environmental variables                                                                                             #
#######################################################################################################################

#export EDITOR=nvim

# Python
export PYENV_ROOT="$HOME/.pyenv"
export CLOUDSDK_PYTHON="$PYENV_ROOT/shims/python"
export PIPENV_VERBOSITY=-1 # hush pipenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export TFENV_ROOT="$HOME/.tfenv"
export PATH="$TFENV_ROOT/bin:$PATH"

# path updates in zsh, per https://stackoverflow.com/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh
# path+=('/path/to/dir')      # append
# path=('path/to/dir' $path)  # prepend
# export PATH                 # don't forget to export PATH

path=("/opt/homebrew/opt/postgresql@13/bin" $path)
#path+=("$HOME/go/bin")
path+=("$HOME/.local/bin")
export PATH

#######################################################################################################################
# History                                                                                                             #
#######################################################################################################################

SHELL_SESSIONS_DISABLE=1 # disable macos terminal restoration

HISTFILE=~/.local/share/zsh/history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory # Share history between sessions
setopt hist_ignore_space # Don't save when prefixed with space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups # Don't save duplicate lines
setopt hist_find_no_dups

#bindkey "^[[A" history-substring-search-up
#bindkey "^[[B" history-substring-search-down

bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history

#######################################################################################################################
# Completions                                                                                                         #
#######################################################################################################################

# Add zsh-completions to fpath
fpath=($HOME/.local/share/zsh/zsh-completions/src $fpath)

# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case-insensitive

# suggested config from https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#configure
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# slight alteration from suggested config
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


#######################################################################################################################
# Aliases and functions                                                                                               #
#######################################################################################################################

alias vim=nvim
# LazyVim distribution
alias nvim-lazy='NVIM_APPNAME="nvim-lazy" nvim'

# ls
alias ls='ls -hF --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -al --color=auto'
alias l='ls -ACF --color=auto'

# filesystem stuff
#alias mkdir='mkdir -p -v'
#alias mv='mv -iv'
#alias rm='rm -Iv --one-file-system --preserve-root'

# repos
alias rdata="cd $HOME/recidiviz/recidiviz-data"
#alias rscripts="cd $HOME/recidiviz/data-scripts"
alias pshell="pipenv shell"

# fun
alias wtf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias v='fd --type f --hidden --exclude .git | fzf --height=40% --reverse --border | xargs -r nvim'

#######################################################################################################################
# Catppuccin Mocha Colors                                                                                             #
#######################################################################################################################

# zsh-syntax-highlighting catppuccin theme (must be sourced BEFORE the plugin)
source ~/.config/zsh/catppuccin-mocha.zsh

# fzf catppuccin mocha colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# ls colors (catppuccin-flavored via vivid or similar)
export LS_COLORS="di=1;34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

#######################################################################################################################
# Keybindings                                                                                                         #
#######################################################################################################################

# TODO: Think about vi bindings for shell
# set -o vi
bindkey -e

#######################################################################################################################
# Misc                                                                                                                #
#######################################################################################################################

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
eval "$(pyenv init - zsh)"

# rust
#if [[ -e "$HOME/.cargo/env" ]]; then
#  source "$HOME/.cargo/env"
#fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# gcloud
export CLOUDSDK_CONFIG="$HOME/.gcloud"
source ~/google-cloud-sdk/path.zsh.inc
source ~/google-cloud-sdk/completion.zsh.inc

# nvm completions
export NVM_DIR="$HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# some plugins
source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh

source ~/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # says it should be "last"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
