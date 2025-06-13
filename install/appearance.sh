#!/bin/bash

source "./utils/colors.sh"

title "============================================================"
title "                  Appearance Configuration                  "
title "============================================================"

# Confirm installation
print "\n[+] This script is going to configure a new appearance on your system."
read -p "$(print "[+] Are you ready to proceed? (y/n) ")" answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    error "[!] The configuration has been stopped. Bye! \n"
    exit 0
fi

print "\n[+] Starting the system customization...\n"

sudo apt update

# Install the new theme
print "\n[+] Installing 'Arc' theme..."
sudo apt install arc -y

# Uninstall a theme from the system
# sudo rm -rf /usr/share/themes/{[theme1], [theme2], ...}

# Install the new icons
print "\n[+] Installing 'Newaita' icons..."
git clone https://github.com/cbrnix/Newaita.git
cd Newaita
sudo mv Newaita/ /usr/share/icons/
sudo mv Newaita-dark/ /usr/share/icons/

# Install GNOME shell extension installer
print "\n[+] Installing gnome-shell-extension-installer..."
sudo curl -o /usr/local/bin/gnome-shell-extension-installer \
     https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
sudo chmod +x /usr/local/bin/gnome-shell-extension-installer

# Extensions declaration
declare -A EXTENSIONS=(
    [307]="dash-to-dock@micxgx.gmail.com"    # Dash to Dock
    [2087]="ding@rastersoft.com"             # Desktop Icons NG (DING)
    [1460]="Vitals@CoreCoding.com"           # Vitals
    [4451]="logomenu@aryan_k"                # Logo Menu
    [3193]="blur-my-shell@aunetx"            # Blur My Shell
    [6]="apps-menu@gnome-shell-extensions.gcampax.github.com"      # Applications Menu
    [7]="drive-menu@gnome-shell-extensions.gcampax.github.com"     # Removable Drive Menu
    [8]="places-menu@gnome-shell-extensions.gcampax.github.com"    # Places Status Indicator
    [19]="user-theme@gnome-shell-extensions.gcampax.github.com"    # User Themes
)

# Install extensions
print "\n[+] Installing extensions..."
for ID in "${!EXTENSIONS[@]}"; do
    print "[+] Installing extension $ID..."
    gnome-shell-extension-installer "$ID" --yes || error "[!] Something goes wrong while installing the extension $ID."
done

# Enable the full appearance
print "\n[+] Applying the new appearance..."
if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.interface gtk-theme "Arc-Darker"
    gsettings set org.gnome.desktop.wm.preferences theme "Arc-Darker"
    print "[+] New theme enabled."
    gsettings set org.gnome.desktop.interface icon-theme "Newaita"
    print "[+] New icons enabled."
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
    print "[+] Maximize, minimize and close windows buttons enabled."
else
    error "[!] No gsettings detected. Apply the new appearance manually from GNOME Tweaks."
fi

print "\n[+] Everything installed and configured!"
print "[+] Reboot GNOME Shell (Alt+F2, write 'r', press Enter) or log in again to apply the changes.\n"
