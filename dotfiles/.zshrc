if where starship > /dev/null ; then
    eval "$(starship init zsh)"
else
    brew install starship
fi

if where pyenv > /dev/null ; then
    export PATH="$PYENV_ROOT/shims:$PATH"
    eval "$(pyenv init -)"
fi

source /opt/homebrew/opt/zinit/zinit.zsh
if where zinit > /dev/null ; then
  source /opt/homebrew/opt/zinit/zinit.zsh
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
else
    brew install zinit
    #source /opt/homebrew/opt/zinit/zinit.zsh
fi

if where nodeenv > /dev/null ; then
    eval "$(nodenv init -)"
fi

## / initialize

function upgrade() {
  brew cleanup
  brew update
  brew upgrade
  brew upgrade --cask
  brew upgrade --cask --greedy
  #npm cache verify
  #npm update -g
  #npm upgrade -g
  #gcloud components update
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

function fetchall() {
  ls ~/work/ | awk '{print "cd ~/work/" $1 "&& pwd && git fetch && git gc"}' | bash
  say done
}

function replace-githooks() {
  if [ -e .git/hooks ]; then
    rm -rf .git/hooks
    ln -s ~/.git_template/hooks .git/hooks
  fi
}

function initshell() {
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
  zinit light zdharma-continuum/fast-syntax-highlighting
  zinit light zsh-users/zsh-history-substring-search
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  zinit light reegnz/jq-zsh-plugin

  # aliases
  alias ll='exa -la --icons'
  #alias ls='exa --icons'
  #alias xs='ls'
  alias mv='mv -i'

  # functionable
  alias upgrade='upgrade'
  alias fetchall='fetchall'
  alias mkcd='mkcd'
  alias pwdc='pwd | tr -d "\n" | pbcopy'
}

#srenexttoken() {
#    profile_name=srelounge
#    code=$1
#    mfa_device=arn:aws:iam::549656562940:mfa/saitotak
#    session_token=$(aws sts get-session-token --serial-number $mfa_device --token-code $code --profile $profile_name)
#    export AWS_ACCESS_KEY_ID=$(echo $session_token | jq -r .Credentials.AccessKeyId)
#    export AWS_SECRET_ACCESS_KEY=$(echo $session_token | jq -r .Credentials.SecretAccessKey)
#    export AWS_SESSION_TOKEN=$(echo $session_token | jq -r .Credentials.SessionToken)
#}

initshell
