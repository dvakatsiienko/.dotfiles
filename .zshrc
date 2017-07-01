export ZSH=/Users/mike/.oh-my-zsh

ZSH_THEME="spaceship"
SPACESHIP_PROMPT_SYMBOL="λ"
SPACESHIP_PROMPT_SEPARATE_LINE="false"
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_DIR_PREFIX="=> "
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_GIT_PREFIX="=>"
SPACESHIP_GIT_SYMBOL="  "
SPACESHIP_GIT_BRANCH_COLOR="blue"
SPACESHIP_NODE_SHOW="false"
SPACESHIP_PROMPT_ORDER=(
    char          # Prompt character
    dir           # Current directory section
    time          # Time stampts section
    user          # Username section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    hg            # Mercurial section (hg_branch  + hg_status)
    node          # Node.js section
    ruby          # Ruby section
    xcode         # Xcode section
    swift         # Swift section
    golang        # Go section
    php           # PHP section
    rust          # Rust section
    haskell       # Haskell Stack section
    julia         # Julia section
    docker        # Docker section
    venv          # virtualenv section
    pyenv         # Pyenv section
    exec_time     # Execution time
    line_sep      # Line break
    vi_mode       # Vi-mode indicator
)

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Plugins

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Global configs

export EDITOR='vim'
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Tuning

alias v="open -a macvim"
alias vv="vim"
alias k="lsof -i tcp:3000"
alias kk="kill -9"
alias ctags="`brew --prefix`/bin/ctags"
alias y='yarn'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yre='yarn remove'
alias yr='yarn run'
alias yo='yarn outdated'
alias yu='yarn upgrade'
alias yui='yarn upgrade-interactive'
alias rb="git cherry -v dev | wc -l | sed 's/ //g' |  { IFS= read -r tail; git rebase -i  HEAD~$tail; }"
alias t="git cherry -v dev | wc -l | sed 's/ //g'"

PATH=/opt/local/bin:$PATH

# for remote in $(git remote); do git remote rm $remote; done
# for branch in $(git branch -a | grep -v master); do git branch -D $branch; done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "/Users/mike/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# Homebrew requires /usr/local/bin occurs before /usr/bin in PATH
export PATH="/usr/local/bin:$PATH"
