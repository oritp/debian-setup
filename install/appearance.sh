#!/bin/bash

source "./utils/colors.sh"

title "============================================================"
title "                  Appearance Configuration                  "
title "============================================================\n"

sudo apt update

#sudo rm -rf /usr/share/themes/Flat-Remix-*
#print "\n[+] Installing Arc theme..."
#sudo apt install -y arc-theme
print "\n[+] Installing Graphite GTK theme..."
sudo git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme
sudo bash install.sh

print "\n[+] Installing Newaita icons..."
#git clone https://github.com/cbrnix/Newaita.git
#cd Newaita
#sudo mv Newaita/ /usr/share/icons/
#sudo mv Newaita-dark/ /usr/share/icons/

print "\n[+] Installing gnome-shell-extension-installer..."
sudo curl -o /usr/local/bin/gnome-shell-extension-installer \
     https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
sudo chmod +x /usr/local/bin/gnome-shell-extension-installer

declare -A EXTENSIONS=(
    [84]="dash-to-dock@micxgx.gmail.com"    # Dash to Dock
    [63]="ding@rastersoft.com"              # Desktop Icons NG (DING)
    [61]="Vitals@CoreCoding.com"            # Vitals
    [24]="LogoMenu@aryan_k"                 # Logo Menu
    [11]="tophat@fflewddur"                 # Top Hat
    [7]="panel-corners@steve_Braun.net"     # Panel Corners
    [47]="blur-my-shell@aunetx"             # Blur My Shell
    [52]="removable-drive-menu@gnome-shell-extensions.gcampax.github.com"              # Removable Drive Menu
)

print "\n[+] Installing extensions..."
#for ID in "${!EXTENSIONS[@]}"; do
#    gnome-shell-extension-installer "$ID" --yes || error "[!] Something goes wrong while installing the extension $ID"
#done

print "\n[+] Enabling extensions..."
#for UUID in "${EXTENSIONS[@]}"; do
#    gnome-extensions enable "$UUID" || error "[!] The extension $UUID cannot be installed."
#done
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable places-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable applications-menu@gnome-shell-extensions.gcampax.github.com




print "\n[+] Applying the new appearance..."
if command -v gsettings &> /dev/null; then
    print "[+] Enabling new theme..."
    #gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix"
    #gsettings set org.gnome.desktop.wm.preferences theme "Flat-Remix"
    print "[+] Enabling new icons..."
    gsettings set org.gnome.desktop.interface icon-theme "Newaita"
    print "[+] Enabling maximize, minimize and close windows buttons..."
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
    print "[+] Settings applied."
else
    error "[!] No gsettings detected. Apply themes manually from GNOME Tweaks."
fi

print "\n[+] Everything installed and configured!"
print "[+] Reboot GNOME Shell (Alt+F2, write 'r' and then press Enter) or log in again to apply the changes."
