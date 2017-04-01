mkdir ~/.ssh
ssh-keygen -t rsa -b 4096 -C "imagnum.satellite@gmail.com"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/github
pbcopy < ~/.ssh/github.pub

echo 'git clone git@github.com:mike-midnight/.dotfiles.git'

