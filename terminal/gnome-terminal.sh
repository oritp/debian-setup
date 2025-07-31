#!/bin/bash

source "./utils/colors.sh"

title "=========================================================="
title "                GNOME Terminal Customization              "
title "=========================================================="

# Colors
ORANGE='#FAA24D'
BLUE='#5C82FA'
BG='#619BC7'

# Get the default ID
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
PROFILE_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

print "\nApplying changes to: $PROFILE_ID"

# Applying custom appearance to GNOME Terminal
gsettings set $PROFILE_PATH use-theme-colors false
gsettings set $PROFILE_PATH background-color "$BG"
gsettings set $PROFILE_PATH use-transparent-background true
gsettings set $PROFILE_PATH background-transparency-percent 50

# Customize prompt (PS1)
CUSTOM_PROMPT='export PS1="\[\e[1;38;5;208m\]\h\[\e[0m\]:\[\e[1;38;5;33m\]\w\[\e[0m\]\\$ "'

# Add to the end of ~/.bashrc
if ! grep -Fxq "$CUSTOM_PROMPT" ~/.bashrc; then
  print "\n# Custom GNOME Terminal prompt\n$CUSTOM_PROMPT" >> ~/.bashrc
  print "Custom prompt added to ~/.bashrc"
else
  print "The custom prompt is already in ~/.bashrc"
fi

print "\nDone! Reboot GNOME Terminal to apply the new configuration."
