#!/bin/bash

source "./utils/colors.sh"

title "==========================================================="
title "              Visual Studio Code Installation              "
title "==========================================================="

# Confirm installation
print "\n[+] This script is going to install Visual Studio Code on your system."
read -p "$(print "[+] Are you ready to proceed? (y/n) ")" answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    error "[!] The installation has been stopped. Bye! \n"
    exit 0
fi

print "\n[+] Starting the Visual Studio Code installation...\n"

# Install requierements
sudo apt update
sudo apt install -y wget gpg apt-transport-https

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

print "\n[+] Visual Studio Code installed successfully! \n"
