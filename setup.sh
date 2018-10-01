#!/usr/bin/env bash
# This is an optional script that helps install some base 
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine=Unknown
esac

if [[ $machine != "Mac" ]]; then
  echo "Error: This script can only be run on a mac"
  exit 1
fi

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
xcode-select --install
echo "Please press enter to install"
if ! $(command -v brew >/dev/null); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade --all

brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
brew install gnu-sed --with-default-names
brew install bash gnu-tar git coreutils moreutils findutils awscli
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
brew install wget --with-iri
brew install vim --override-system-vi

echo 'export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"' >> ~/.bash_profile
