#!/bin/bash

source "./utils/colors.sh"

print "============================================================"
print "                    Spotify Installation                    "
print "============================================================"

# Confirm installation
print "\n[+] This script is going to install Spotify on your system."
read -p "$(print "[+] Are you ready to proceed? (y/n) ")" answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    error "[!] The installation has been stopped. Bye! \n"
    exit 0
fi

print "\n[+] Starting the Spotify installation...\n"

# Download and store the Spotify public key
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/spotify-archive-keyring.gpg > /dev/null

# Add the Spotify official repository
echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] https://repository.spotify.com stable non-free" | \
  sudo tee /etc/apt/sources.list.d/spotify.list

# Install Spotify
sudo apt update
sudo apt install -y spotify-client

print "\n[+] Spotify installed successfully! \n"
