# Pre-requisite - system setup ssh agent with keys

# Brew
ruby -e "$(curl -fsSL https://
raw.githubusercontent.com/Homebrew/install/master/install)"

# Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# brew-cask install
brew install brew-cask

# ctags for vim
brew install ctags

# hub - command-line wrapper for git that makes you better at GitHub
brew install hub

# brew formulas
brew cask install chrome
brew cask install node
brew cask install yarn
brew cask install the_silver_searcher
brew cask install google-drive 
brew cask install skyfonts
brew cask install skype
brew cask install atom
brew cask install webstorm
brew cask install alfred

# Node permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

# Command line tools 
xcode-select --install

# zsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# switch to zsh
chsh -s $(which zsh)
exec zsh

# remove .bash meta info
cd ~
rm .bash_history
rm -rf .bash_sessions

# install powerline fonts
git clone https://github.com/powerline/fonts.git && cd fonts && sh install.sh && cd .. && rm -rf fonts

# install nerd fonts
git clone git@github.com:ryanoasis/nerd-fonts.git && cd nerd-fonts && sh install.sh && cd .. && rm -rf nerd-fonts

# turn off FaceTime sounds on mac
sudo defaults write ~/Library/Containers/com.apple.tonelibraryd/Data/Library/Preferences/com.apple.ToneLibrary.plist ringtone "system:"

