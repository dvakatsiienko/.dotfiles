# Pre-requisite - system setup ssh agent with keys

# mkdir ~/.ssh
# ssh-keygen -t rsa -b 4096 -C "imagnum.satellite@gmail.com"
# eval "$(ssh-agent -s)"
# ssh-add -K ~/.ssh/github
# pbcopy < ~/.ssh/github.pub
# git clone git@github.com:mike-midnight/.dotfiles.git

# TODO
# up vote
# 93
# down vote
# accepted
# You can also change the preference keys directly:
# 
# defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
# defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
# The changes aren't applied until you log out and back in. KeyRepeat can't be set between 2 (30 ms) and 1 (15 ms) though.
# 
# I also use KeyRemap4MacBook. I've set the repeat rates to 40 ms and the initial repeat rates to 150 ms.

# Command line tools
xcode-select --install

# omzsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# switch to zsh
# chsh -s $(which zsh)
# exec zsh

# remove .bash meta info
rm ~/.bash_history
rm -rf ~/.bash_sessions

# Homebrew permissions fix
sudo chown -R "$USER":admin /usr/local

# Brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Vim Plug install
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ctags for vim
brew install ctags

# hub - command-line wrapper for git that makes you better at GitHub
brew install hub

# Classic formulas
brew install node
brew install yarn
brew install the_silver_searcher

# Node permissions fix
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

# brew cask formulas
brew cask install google-chrome
brew cask install google-drive 
brew cask install skyfonts
brew cask install skype
brew cask install atom
brew cask install webstorm
brew cask install alfred

# Install powerline fonts
git clone git@github.com:powerline/fonts.git ~/fonts && sh ~/fonts/install.sh && rm -rf ~/fonts

# Install nerd fonts
git clone git@github.com:ryanoasis/nerd-fonts.git ~/nerd-fonts && sh ~/nerd-fonts/install.sh && rm -rf ~/nerd-fonts

# Turn off FaceTime sounds on mac
sudo defaults write ~/Library/Containers/com.apple.tonelibraryd/Data/Library/Preferences/com.apple.ToneLibrary.plist ringtone "system:"

