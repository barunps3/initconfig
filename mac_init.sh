#!/bin/bash
# Install all in admin mode

# Update package manager
brew update
softwareupdate --all --install --force

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install wget
brew install wget

# Install neovim editor
brew install neovim

# Install azure cli
brew install azure-cli

#Install aws cli
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# Install latest terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Install kubectl
brew install kubectl 

# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube
