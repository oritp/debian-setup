#!/bin/bash

source "./utils/colors.sh"

print "############################################################"
print "#                                                          #"
print "#                Debian 12 GNU/Linux Setup                 #"
print "#                                                          #"
print "############################################################"

# Enabling execution permissions
chmod +x ./install/essentials.sh
chmod +x ./terminal/terminal.sh
chmod +x ./install/appearance.sh
chmod +x ./install/vscode.sh
chmod +x ./install/spotify.sh

print "\n[+] Welcome to Debian 12 Setup Menu!"
print "[+] What do you want to install?"
print "    1. Everything"
print "    2. Essential configuration"
print "    3. Terminal configuration"
print "    4. Appearance configuration"
print "    5. VS Code"
print "    6. Spotify"

read -p "$(print "[+] Choose an option [1-5]: ")" option
print ""

case $option in
    1) bash install/essentials.sh
       bash terminal/terminal.sh
       bash install/appearance.sh
       bash install/vscode.sh
       bash install/spotify.sh ;;
    2) bash install/essentials.sh ;;
    3) bash terminal/terminal.sh ;;
    4) bash install/appearance.sh ;;
    5) bash install/vscode.sh ;;
    6) bash install/spotify.sh ;;
    *) error "[!] Invalid option. Bye! \n"
       exit 0 ;;
esac
