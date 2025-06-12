#!/bin/bash

source "./utils/colors.sh"

sudo apt update

print "\nInstalling Arc theme..."
sudo apt install -y arc-theme

print "\nInstalling Newaita icons..."
git clone https://github.com/cbrnix/Newaita.git
cd Newaita
sudo mv Newaita/ /usr/share/icons/
sudo mv Newaita-dark/ /usr/share/icons/

print "Installing gnome-shell-extension-installer..."
sudo curl -o /usr/local/bin/gnome-shell-extension-installer \
     https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
sudo chmod +x /usr/local/bin/gnome-shell-extension-installer

declare -A EXTENSIONS=(
    [307]="dash-to-dock@micxgx.gmail.com"     # Dash to Dock
    [2087]="ding@rastersoft.com"              # Desktop Icons NG (DING)
    [1460]="Vitals@CoreCoding.com"            # Vitals
    [4420]="openbar@neuromorph"               # Open Bar
    [4454]="LogoMenu@aryan_k"                 # Logo Menu
    [4169]="tophat@fflewddur"                 # Top Hat
    [4098]="panel-corners@steve_Braun.net"    # Panel Corners
    [3193]="blur-my-shell@aunetx"             # Blur My Shell
)

print "\nInstalling extensions..."
for ID in "${!EXTENSIONS[@]}"; do
    gnome-shell-extension-installer "$ID" -y || error "Something goes wrong while installing the extension $ID"
done

print "\nEnabling extensions..."
for UUID in "${EXTENSIONS[@]}"; do
    gnome-extensions enable "$UUID" || error "The extension $UUID cannot be installed."
done

print "\nApplying the new appearance..."
if command -v gsettings &> /dev/null; then
    print "Enabling new theme..."
    gsettings set org.gnome.desktop.interface gtk-theme "Arc"
    gsettings set org.gnome.desktop.wm.preferences theme "Arc"
    print "Enabling new icons..."
    gsettings set org.gnome.desktop.interface icon-theme "Newaita"
    print "Enabling maximize, minimize and close windows buttons..."
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
    print "Settings applied. Please log in again if you don't see the changes."
else
    error "No gsettings detected. Apply themes manually from GNOME Tweaks."
fi

print "\nEverything installed and configured!"
print "Reboot GNOME Shell (Alt+F2, write 'r' and then press Enter) or log in again to apply the changes."
