#!/bin/bash

echo "========================================="
echo "     Visual Studio Code installation     "
echo "========================================="

# Confirm installation
echo -e "\nThis script is going to install Visual Studio Code in your system."
read -p "Are you ready to proceed? (y/n) " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo -e "The installation has been stopped. Bye! \n"
    exit 0
fi

echo -e "\nStarting the Visual Studio Code installation...\n"

# Install requierements
sudo apt-get update
sudo apt-get install -y wget gpg apt-transport-https

# Download and store the Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
   gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

# Add the VS Code official repository
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

# Update and install VS Code
sudo apt update
sudo apt install -y code

echo -e "\nVisual Studio Code installed successfully! \n"
