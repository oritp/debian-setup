#!/bin/bash

RED='\e[0;31m'
CYAN='\e[0;36m'
AUTO='\e[0m'

print() { echo -e "${CYAN}$1${AUTO}"; }
error() { echo -e "${RED}$1${AUTO}"; }

print "==========================================================="
print "             Debian 12 Essential Configuration             "
print "==========================================================="

# Confirm installation
print "\n[+] This script is going to run several processes in your system."
read -p "$(print "[+] Are you ready to proceed? (y/n) ")" answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    error "[!] The installation has been stopped. Bye! \n"
    exit 0
fi

print "\n[+] Starting Debian 12 essential configuration...\n"

# ----------------------------------------------------------------
# 1. Update system and enable backports
# ----------------------------------------------------------------
print "\n[+] Updating system..."
sudo apt update && sudo apt dist-upgrade -y

print "\n[+] Enabling backports repository..."
echo "deb http://deb.debian.org/debian bookworm-backports main" | \
  sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update

print "\n[+] Installing latest GNU/Linux kernel from backports..."
sudo apt install -y -t bookworm-backports linux-image-amd64

# ----------------------------------------------------------------
# 2. Essential tools and utilities
# ----------------------------------------------------------------
print "\n[+] Installing essential tools and CLI utilities..."
sudo apt install -y \
  sudo curl wget git vim gpg \
  neofetch htop btop inxi \
  gnupg lsb-release ca-certificates \
  software-properties-common
  
# ----------------------------------------------------------------
# 3. File managers
# ----------------------------------------------------------------
print "\n[+] Installing file system support and decompressors..."
sudo apt install -y \
  exfat-fuse hfsplus hfsutils ntfs-3g \
  unzip zip p7zip-full p7zip-rar unrar-free rar

print "\n[+] Installing additional package managers..."
sudo apt install -y \
  synaptic gdebi-core \
  flatpak gnome-software-plugin-flatpak
  
sudo flatpak remote-add --if-not-exists \
  flathub https://flathub.org/repo/flathub.flatpakrepo

# ----------------------------------------------------------------
# 4. CPU microcode
# ----------------------------------------------------------------
print "\n[+] Installing CPU microcode..."
if grep -q "GenuineIntel" /proc/cpuinfo; then
  sudo apt install -y intel-microcode
elif grep -q "AuthenticAMD" /proc/cpuinfo; then
  sudo apt install -y amd64-microcode
fi

# ----------------------------------------------------------------
# 5. Dev and net tools
# ----------------------------------------------------------------
print "\n[+] Installing development tools..."
sudo apt install -y \
  build-essential \
  gcc g++ make cmake \
  pkg-config gdb clang \
  python3 python3-pip python3-venv
  
print "\n[+] Installing networking tools..."
sudo apt install -y \
  net-tools iproute2 traceroute tcpdump whois nmap

# ----------------------------------------------------------------
# 6. Multimedia support
# ----------------------------------------------------------------
print "\n[+] Installing multimedia codecs and support..."
sudo apt install -y \
  ffmpeg \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-* \
  gstreamer1.0-pulseaudio \
  libavcodec-extra

# ----------------------------------------------------------------
# 7. Fonts, printers, firewalls and useful programs
# ----------------------------------------------------------------
print "\n[+] Installing fonts..."
sudo apt install -y \
  ttf-mscorefonts-installer \
  fonts-ubuntu \
  fonts-freefont-ttf fonts-freefont-otf

print "\n[+] Installing printer drivers..."
sudo apt install -y \
  cups system-config-printer printer-driver-all

print "\n[+] Installing firewall and VPN..."
sudo apt install -y \
  gufw riseup-vpn

print "\n[+] Installing useful programs..."
sudo apt install -y \
  kitty firefox chromium gimp vlc wireshark

# ----------------------------------------------------------------
# 8. GNOME configuration
# ----------------------------------------------------------------
print "\n[+] Installing GNOME configuration tools..."
sudo apt install -y \
  gnome-tweaks \
  gnome-shell-extensions \
  chrome-gnome-shell \
  gnome-shell-extension-prefs \
  dconf-editor

# ----------------------------------------------------------------
# 9. Final cleaning
# ----------------------------------------------------------------
print "\n[+] Final cleaning..."
sudo apt update
sudo apt autoremove -y
sudo apt clean

print "\nAll done! Reboot your system to apply all the changes.\n"
