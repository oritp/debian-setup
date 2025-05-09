#!/bin/bash

echo "==========================="
echo "      DEBIAN 12 SETUP      "
echo "==========================="

echo "[+] Updating system..."
sudo apt update && sudo apt dist-upgrade -y

echo "[+] Updating backports..."
deb http://deb.debian.org/debian bookworm-backports main
sudo apt install -y -t bookworm-backports linux-image-amd64

echo "[+] Installing essential packets and file decompressors..."
sudo apt install -y \
  sudo curl wget git vim gpg neofetch htop btop inxi \
  gnupg lsb-release ca-certificates \
  software-properties-common \
  exfat-fuse hfsplus hfsutils ntfs-3g \
  unzip zip p7zip-full p7zip-rar unrar-free rar

echo "[+] Final cleaning..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt clean

echo -e "All done! \nReboot your system to apply all the changes. \nEnjoy!"
