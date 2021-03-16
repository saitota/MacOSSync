
if [ -e /usr/local/bin/starship ]; then
    echo 'init starship'
    eval "$(starship init zsh)"
fi
if [ -e ~/.pyenv/ ]; then
    echo 'set pyenv path'
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi
if [ -e ~/.zinit/bin/zinit.zsh ]; then
    echo 'set zinit path'
    source ~/.zinit/bin/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit
else
    echo 'install zinit'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    source .zshrc
fi
# jdk
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# export PATH=${JAVA_HOME}/bin:${PATH}

# set openssl version
# export PATH=/usr/local/Cellar/openssl@1.1/1.1.1g/bin/:$PATH

# add chromedriver for selenium

# zsh
autoload -Uz compinit # hokan
compinit -u
autoload -U colors # colorize
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "

# zsh/list
setopt mark_dirs
setopt list_types
setopt list_packed
setopt print_eight_bit

# zsh/complement
setopt correct
setopt auto_cd
setopt complete_in_word
setopt magic_equal_subst
setopt auto_param_slash
setopt auto_pushd
setopt pushd_ignore_dups
setopt always_last_prompt

# zsh/history configure
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt append_history
setopt extended_history
setopt hist_ignore_space
setopt hist_save_no_dups

# zsh plugins: zinit lists
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zinit light reegnz/jq-zsh-plugin

# zsh plugin: enhancd
#zinit ice \
#  atclone'rm -rf conf.d; rm -rf functions; rm -f *.fish;' \
#  pick'init.sh' \
#  nocompile'!' \
#  wait'!0' 
#zinit light b4b4r07/enhancd
#export ENHANCD_FILTER=fzf
#export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# experience
#alias jq='echo "use jid instead"'
#alias cat='echo "use bat instead"'
alias ag='echo "use rg instead"'
#alias ls='echo "use exa instead"'
#alias ll='echo "use exa instead"'

# aliases
#alias la='ls -la'
alias ll='ls -laGF'
#alias u='cd ..'
#alias uu='cd ../..'
#alias uuu='cd ../../..'
# alias uuuu='cd ../../../..'
#alias g='git'
#alias ga='git add'
#alias gd='git diff'
#alias gs='git status'
#alias gsw='git switch'
#alias gp='git push'
#alias gpu='git pull'
#alias gb='git branch'
#alias gco='git checkout'
#alias gf='git fetch'
#alias gc='git commit'
alias zshrc='code ~/.zshrc'
#alias fixsaml2aws='git -C /usr/local/Homebrew/Library/Taps/versent/homebrew-taps checkout  0e9738c089cc44e5f19c7879ec890b10bbd42dc9 saml2aws.rb && brew reinstall saml2aws && git -C /usr/local/Homebrew/Library/Taps/versent/homebrew-taps reset --hard'
# safety guard
#alias cp='cp -i'
alias mv='mv -i'
#alias rm='rm -i'
#alias rm='rmtrash'
#alias realrm='rm'
# one word
#alias d='docker'
#alias h='history | grep'
#alias k='kubectl'
#alias m='mkdir'
#alias v='code'
# functionable
alias upgrade='upgrade'
alias fetchall='fetchall'
alias mkcd='mkcd'

function upgrade() {
  brew cleanup
  brew update
  brew upgrade
  brew upgrade --cask
  brew cleanup
  npm update -g
  npm upgrade -g
  gcloud components update
  echo "--upgraded"
  brew list
  echo "--"
  brew list --cask
  echo "--"
  # npm list -g
  say done
}

function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}
alias pwdc='pwd | tr -d "\n" | pbcopy'

function fetchall() {
  ls ~/work/ | awk '{print "cd ~/work/" $1 "&& pwd && git fetch"}' | bash
  say done
}

function replace-githooks() {
  if [ -e .git/hooks ]; then
    rm -rf .git/hooks
    ln -s ~/.git_template/hooks .git/hooks
  fi
}

# use z history
#. ~/z.sh