#!/bin/bash

RED='\e[0;31m'
CYAN='\e[0;36m'
AUTO='\e[0m'

print() { echo -e "${CYAN}$1${AUTO}"; }
error() { echo -e "${RED}$1${AUTO}"; }

print "============================================================"
print "                     Debian 12 Setup Menu                   "
print "============================================================"

print "\n[+] Welcome to Debian 12 Setup Menu!"
print "[+] What do you want to install?"
print "    1. Everything"
print "    2. Essential configuration"
print "    3. Terminal configuration"
print "    4. VS Code"
print "    5. Spotify"

read -p "$(print "[+] Choose an option [1-5]: ")" option

case $option in
    1) bash install/essentials.sh
       bash install/vscode.sh
       bash install/spotify.sh ;;
    2) bash terminal/config.sh ;;
    3) bash install/essentials.sh ;;
    4) bash install/vscode.sh ;;
    5) bash install/spotify.sh ;;
    *) error "[!] Invalid option. Bye! \n"
       exit 0 ;;
esac
