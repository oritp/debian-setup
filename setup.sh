#!/bin/bash

source "./utils/colors.sh"

title "############################################################"
title "#                                                          #"
title "#                Debian 12 GNU/Linux Setup                 #"
title "#                                                          #"
title "############################################################"

# Enabling execution permissions
chmod +x ./install/essentials.sh
chmod +x ./install/appearance.sh
chmod +x ./terminal/gnome-terminal.sh
chmod +x ./terminal/kitty-terminal.sh
chmod +x ./install/vscode.sh
chmod +x ./install/spotify.sh

print "\n[+] Welcome to Debian 12 Setup Menu!"
print "[+] What do you want to install?"
print "    1. Everything"
print "    2. Essential configuration"
print "    3. Appearance configuration"
print "    4. Terminal configuration"
print "    5. VS Code"
print "    6. Spotify"

read -p "$(print "[+] Choose an option [1-6]: ")" option
print ""

case $option in
    1) bash install/essentials.sh
       bash install/appearance.sh
       bash terminal/gnome-terminal.sh
       bash terminal/kitty-terminal.sh
       bash install/vscode.sh
       bash install/spotify.sh ;;
    2) bash install/essentials.sh ;;
    3) bash install/appearance.sh ;;
    4) bash terminal/gnome-terminal.sh 
       bash terminal/kitty-terminal.sh ;;
    5) bash install/vscode.sh ;;
    6) bash install/spotify.sh ;;
    *) error "[!] Invalid option. Bye! \n"
       exit 0 ;;
esac
