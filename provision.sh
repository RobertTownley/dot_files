#!/bin/bash

# DESCRIPTION
# This is the script I use to initialize new computers. It's written with Ubuntu in mind, but it might
# work for any UNIX/LINUX based system.
#
# If you trust me not to mess up your computer, you can run the following: 
# source <(curl -s https://raw.githubusercontent.com/RobertTownley/dot_files/master/provision.sh)

# SCRIPT
# Gather user preferences
printf "What full name will you use with Git? (default: Robert Townley): "
read -r NAME
NAME="${NAME:-Robert Townley}"

printf "What email address will you use for SSH keys? (default: me@roberttownley.com): "
read -r EMAIL
EMAIL="${EMAIL:-me@roberttownley.com}"

# Upgrade system
sudo apt update && sudo apt upgrade
sudo apt autoremove -y

# Install filesystem, command line, and programming utilities
sudo apt install vim  # Preferred text editor
sudo apt install silversearcher-ag  # File search utility (grep with superpowers)
sudo apt install curl  # Utility for grabbing files online
sudo apt install git  # Version control system
sudo apt install flake8  # Python syntax checking module
sudo apt install xclip

# Set up preferred directories
mkdir ~/Laboratory  # Where I experiment with things I'm currently learning
mkdir ~/Projects  # Where I keep all projects

# Create SSH keys
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f $HOME/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
echo "SSH key copied to system clipboard for pasting into Github/Gitlab. It's also printed below:"
echo "==========================================="
cat ~/.ssh/id_rsa.pub
echo "==========================================="

# Configure Git
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

# Copy my preferred dotfiles into place
if [ ! -d ~/Projects/dot_files ]; then
  cd ~/Projects
  git clone https://github.com/RobertTownley/dot_files.git
  cd dot_files
  cp .tmux.conf ~/.tmux.conf
  cp .vimrc ~/.vimrc
  cp .profile ~/.profile

  # Need to do this because https requires user input, but we want ssh eventually so I can commit back
  rm -rf .git
  git init
  git remote add origin git@github.com:RobertTownley/dot_files.git
  cd ~
fi

# Set up Vim
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim -c 'PluginInstall' -c 'qa!'
fi

