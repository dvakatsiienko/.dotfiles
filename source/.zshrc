# Oh My ZSH variables
export ZSH=$HOME/.oh-my-zsh # Path to oh-my-zsh installation.
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST # Store zsh's completion cache inside oh-my-zsh cache folder

# 1Password variables
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

ZSH_CUSTOM=$HOME/.config/oh-my-zsh-custom # my oh-my-zsh customization folder. contains aliases, functions, plugins, etc.

# Oh My Zsh plugins
# TODO: Try plugins
# plugins=(alias-finder brew common-aliases copydir copyfile docker docker-compose dotenv encode64 extract git jira jsontools node npm npx osx urltools vscode web-search z)
plugins=( z )

source $ZSH/oh-my-zsh.sh

# User Configuration
export EDITOR=vim # Default editor
export BAT_THEME=gruvbox-dark # Set bat theme
export FZF_DEFAULT_COMMAND='find * -type f' # tells fzf to include hiden files in search results

# Init nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Init starship
eval "$(starship init zsh)"

# Custom zsh plugins installed with homebrew because antigen (zsh plugin manager) is deprecated.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
