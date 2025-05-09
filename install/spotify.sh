#!/bin/bash

echo "============================================================"
echo "                    Spotify installation                    "
echo "============================================================"

# Confirm installation
echo -e "\nThis script is going to install Spotify on your system."

echo -e "\nStarting the Spotify installation...\n"

# Download and store the Spotify public key
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/spotify-archive-keyring.gpg > /dev/null

# Add the Spotify official repository
echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] https://repository.spotify.com stable non-free" | \
  sudo tee /etc/apt/sources.list.d/spotify.list

# Install Spotify
sudo apt update
sudo apt install spotify-client

echo -e "\nSpotify installed successfully! \n"
