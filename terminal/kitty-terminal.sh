#!/bin/bash

source "./utils/colors.sh"

# Colors
OR='#FAA24D'
BL='#5C82FA'
BG='#002b36'

title "=========================================================="
title "                Kitty Terminal Customization              "
title "=========================================================="

# Confirm installation
print "\n[+] This script is going to configure the Kitty Terminal appearance."
read -p "$(print "[+] Are you ready to proceed? (y/n) ")" answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    error "[!] The installation has been stopped. Bye! \n"
    exit 0
fi

print "\n[+] Starting Kitty Terminal configuration..."

# Kitty configuration file route
KITTY_CONF="${HOME}/.config/kitty/kitty.conf"

# Write the custom configuration
cat > "$KITTY_CONF" <<EOF
# Custom colors
background $BG
foreground #ffffff
selection_background #ffffff
selection_foreground #000000

# ANSI colors
color0  #1d1f21
color1  #cc6666
color2  #b5bd68
color3  #f0c674
color4  #81a2be
color5  #b294bb
color6  #8abeb7
color7  #c5c8c6
color8  #969896
color9  #cc6666
color10 #b5bd68
color11 #f0c674
color12 #81a2be
color13 #b294bb
color14 #8abeb7
color15 #ffffff

# Transparency
background_opacity 0.7

# Font
font_family      Monospace
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        11.0
EOF

print "kitty.conf file generated in: $KITTY_CONF"

# Custom prompt for bash
CUSTOM_PROMPT='export PS1="\[\e[1;38;5;208m\]\h\[\e[0m\]:\[\e[1;38;5;33m\]\w\[\e[0m\]\\$ "'

# Add to the end of ~/.bashrc
if ! grep -Fxq "$CUSTOM_PROMPT" ~/.bashrc; then
  echo -e "\n# Custom Kitty Terminal prompt\n$CUSTOM_PROMPT" >> ~/.bashrc
  print "Custom prompt added to ~/.bashrc"
else
  print "The custom prompt is already in ~/.bashrc"
fi

print "\nDone! Reboot Kitty Terminal to apply the new configuration. \n"
