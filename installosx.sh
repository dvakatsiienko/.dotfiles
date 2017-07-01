# Pre-requisite - system ssh agentsetup  with keys

echo 'Setting up a blazingly fast keyboard repeat rate'
defaults write NSGlobalDomain KeyRepeat -int 1

echo 'Setting up a shorter delay until key repeat'
defaults write NSGlobalDomain InitialKeyRepeat -int 10

echo 'Turn off annoying FaceTime ringer on Mac'
sudo defaults write ~/Library/Containers/com.apple.tonelibraryd/Data/Library/Preferences/com.apple.ToneLibrary.plist ringtone "system:"

# Revert to default settings with:
# defaults delete NSGlobalDomain KeyRepeat
# defaults delete NSGlobalDomain InitialKeyRepeat

echo 'Installing xcode command line tools'
xcode-select --install

echo 'Installning Homebrew'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Fixing Homebrew permissions'
sudo chown -R "$USER":admin /usr/local

echo 'Installing classic brew formulas'
brew install node
brew install the_silver_searcher
brew install hub
brew install httpie
brew install macvim

echo 'Installing set of cask formulas'
brew cask install atom
brew cask install google-chrome
brew cask install google-drive
brew cask install postman
brew cask install hyper
brew cask install iterm2
brew cask install skype
brew cask install alfred
brew cask install sip
brew cask install cloudapp
brew cask install appcleaner
brew cask install battle-net
brew cask install steam
brew cask install vlc

echo 'Installing Vim from binaries'
sudo mkdir -p /opt/local/bin
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=/opt/local --with-features=huge --enable-pythoninterp
make
sudo make install

echo 'Fixing npm permissions'
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

echo 'Installing Vim Plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Installing Powerline Fonts'
git clone git@github.com:powerline/fonts.git ~/fonts && sh ~/fonts/install.sh && rm -rf ~/fonts

echo 'Installing Nerd Fonts'
git clone git@github.com:ryanoasis/nerd-fonts.git ~/nerd-fonts && cd ~/nerd-fonts && ./install.sh && cd ~ && rm -rf ~/nerd-fonts

echo 'Deleting old bash meta info'
rm ~/.bash_history
rm -rf ~/.bash_sessions

echo 'Installing omzsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 'Switching to zsh'
if [ $SHELL != '/bin/zsh' ]; then
    chsh -s $(which zsh)
    exec zsh
else
    echo 'Shell is already switched to zsh'
fi

echo 'Installing Yarn'
curl -o- -L https://yarnpkg.com/install.sh | bash

echo 'Changing Yarn global target dir'
yarn config set prefix /usr/local/

echo "Installing .dotfiles"
sh ~/.dotfiles/install.sh

echo "Installing Spaceship zsh theme"
npm install -g spaceship-zsh-theme

echo "Activating terminal themes"
open ~/.dotfiles/themes/gruvbox-dark.terminal
open ~/.dotfiles/themes/gruvbox-light.terminal
open ~/.dotfiles/themes/Treehouse.terminal

