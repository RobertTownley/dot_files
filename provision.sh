#!/bin/bash

# DESCRIPTION
# This is the script I use to initialize new computers. It's written with Ubuntu in mind, but it might
# work for any UNIX/LINUX based system.
#
# If you trust me not to mess up your computer, you can run the following: 
# source <(curl -s https://raw.githubusercontent.com/RobertTownley/dot_files/master/provision.sh)

#~~~BEGIN~SCRIPT~~~#
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
sudo apt install xclip  # Command line utility for copying to system clipboard

# System libraries for common python development tasks
sudo apt install \
  make \
  build-essential \
  exfat-fuse \
  exfat-utils \
  liblzma-dev \
  libbz2-dev \
  libffi-dev \
  libreadline-dev \
  libssl-dev \
  libssl1.0-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libsqlite3-dev\
  libxml2 libxml2-dev \
  libxslt1-dev \
  llvm \
  python-openssl \
  tk-dev \
  xz-utils \
  wget \
  zlib1g-dev
        

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
  source ~/.profile

  # https requires user input, but we want ssh eventually so we can commit back
  rm -rf .git
  git init
  git remote add origin git@github.com:RobertTownley/dot_files.git
  cd ~
fi

# Set up Vim plugins by installing Vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  sudo apt install vim-gtk
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim -c 'PluginInstall' -c 'qa!'
fi

# Use pyenv for python installation management
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER
