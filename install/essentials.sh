#!/bin/bash

echo "==========================================================="
echo "             Debian 12 Essential Configuration             "
echo "==========================================================="

# Confirm installation
echo -e "\n[+] This script is going to run several processes in your system."
read -p "[+] Are you ready to proceed? (y/n) " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo -e "[!] The installation has been stopped. Bye! \n"
    exit 0
fi

echo -e "\n[+] Starting the Debian 12 essential configuration...\n"

# ----------------------------------------------------------------
# 1. Update system and enable backports
# ----------------------------------------------------------------
echo "[+] Updating system..."
sudo apt update && sudo apt dist-upgrade -y

echo "[+] Enabling backports repository..."
echo "deb http://deb.debian.org/debian bookworm-backports main" | \
  sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update

echo "[+] Installing latest GNU/Linux kernel from backports..."
sudo apt install -y -t bookworm-backports linux-image-amd64

# ----------------------------------------------------------------
# 2. Essential tools and utilities
# ----------------------------------------------------------------
echo "[+] Installing essential tools and CLI utilities..."
sudo apt install -y \
  sudo curl wget git vim gpg \
  neofetch htop btop inxi \
  gnupg lsb-release ca-certificates \
  software-properties-common
  
# ----------------------------------------------------------------
# 3. File managers
# ----------------------------------------------------------------
echo "[+] Installing file system support and decompressors..."
sudo apt install -y \
  exfat-fuse hfsplus hfsutils ntfs-3g \
  unzip zip p7zip-full p7zip-rar unrar-free rar

echo "[+] Installing additional package managers..."
sudo apt install -y \
  synaptic gdebi-core \
  flatpak gnome-software-plugin-flatpak
  
sudo flatpak remote-add --if-not-exists \
  flathub https://flathub.org/repo/flathub.flatpakrepo

# ----------------------------------------------------------------
# 4. CPU microcode
# ----------------------------------------------------------------
echo "[+] Installing CPU microcode..."
if grep -q "GenuineIntel" /proc/cpuinfo; then
  sudo apt install -y intel-microcode
elif grep -q "AuthenticAMD" /proc/cpuinfo; then
  sudo apt install -y amd64-microcode
fi

# ----------------------------------------------------------------
# 5. Dev and net tools
# ----------------------------------------------------------------
echo "[+] Installing development tools..."
sudo apt install -y \
  build-essential \
  gcc g++ make cmake \
  pkg-config gdb clang \
  python3 python3-pip python3-venv
  
echo "[+] Installing networking tools..."
sudo apt install -y \
  net-tools iproute2 traceroute tcpdump whois nmap



echo "[+] Detecting GPU..."
GPU_INFO=$(lspci | grep -Ei 'vga\|3d')
echo "$GPU_INFO"

if echo "$GPU_INFO" | grep -qi nvidia; then
  echo "[+] NVIDIA GPU detected, installing drivers..."
  sudo apt install -y nvidia-detect
  DRIVER=$(nvidia-detect | grep -oP 'package:\s*\K[\w\-]+')
  if [ -n "$DRIVER" ]; then
    echo "NVIDIA Driver Recommendation: $DRIVER"
    #sudo apt install -y "$DRIVER"
  else
    echo "The driver could not be detected. Installing general drivers..."
    #echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/disable-nouveau.conf
    #sudo update-initramfs -u
    #sudo apt install -y nvidia-driver firmware-misc-nonfree nvidia-settings
  fi
elif echo "$GPU_INFO" | grep -qi amd; then
  echo "AMD GPU detected, installing drivers..."
  #sudo apt install -y firmware-amd-graphics mesa-vulkan-drivers mesa-va-drivers vainfo
elif echo "$GPU_INFO" | grep -qi intel; then
  echo "[+] INTEL GPU detected, installing drivers..."
  #sudo apt install -y intel-media-va-driver firmware-misc-nonfree mesa-va-drivers vainfo
else
  echo -e "A supported GPU (Intel/AMD/NVIDIA) was not detected or it is virtual.\n"
fi




# ----------------------------------------------------------------
# 5. Multimedia support
# ----------------------------------------------------------------
echo "[+] Installing multimedia codecs and support..."
sudo apt install -y \
  ffmpeg \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-* \
  gstreamer1.0-pulseaudio \
  libavcodec-extra

# ----------------------------------------------------------------
# 6. Fonts, printers, firewalls and useful programs
# ----------------------------------------------------------------
echo "[+] Installing fonts..."
sudo apt install -y \
  ttf-mscorefonts-installer \
  fonts-ubuntu \
  fonts-freefont-ttf fonts-freefont-otf

echo "[+] Installing printer drivers..."
sudo apt install -y \
  cups system-config-printer printer-driver-all

echo "[+] Installing simple firewall and VPN..."
sudo apt install -y \
  gufw riseup-vpn

echo "[+] Installing useful programs..."
sudo apt install -y \
  kitty firefox chromium gimp vlc wireshark

# ----------------------------------------------------------------
# 7. GNOME configuration
# ----------------------------------------------------------------
echo "[+] Installing GNOME configuration tools..."
sudo apt install -y \
  gnome-tweaks \
  gnome-shell-extensions \
  chrome-gnome-shell \
  gnome-shell-extension-prefs \
  dconf-editor

# ----------------------------------------------------------------
# 8. Final cleaning
# ----------------------------------------------------------------
echo "[+] Final cleaning..."
sudo apt update
sudo apt autoremove -y
sudo apt clean

echo -e "\nAll done! \nReboot your system to apply all the changes. \nEnjoy! :)\n"
