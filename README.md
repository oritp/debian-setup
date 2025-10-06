![Debian 12](https://img.shields.io/badge/Platform-Debian%2012-blue?logo=debian)
![Shell](https://img.shields.io/badge/Language-Shell-orange?logo=gnubash)
![License](https://img.shields.io/badge/License-MIT%20License-lightgrey)
![Status](https://img.shields.io/badge/Status-Success-success)

# Debian 12 GNU/Linux Setup

This repository contains a set of shell scripts designed to simplify the initial setup of systems based on Debian 12 GNU/Linux. It provides a quick and customizable installation of essential tools, development environments, system settings, appearance, and popular applications.

This is the repository structure:


## 🛠️ Preliminary Steps

Before running the main script, it is recommended to manually complete the following steps:

#### 1. Hide password input feedback

Access the `sudoers` file located in the `etc` system folder:

    su
    nano /etc/sudoers

Add the following line:

    Defaults pwfeedback

#### 2. Add superuser privileges

If our user (we will call it _[user]_) does not come with predefined admin or superuser privileges, we can fix it by editing:

    nano /etc/sudoers

Scroll down to where users and permissions are listed, and add our user:

    [user] ALL=(ALL:ALL) ALL

Finally, update the system:

    sudo apt update && sudo apt dist-upgrade -y

#### 3. Install graphics drivers

Identify your system's graphics card:

    lspci | grep -i 'vga\|3d'

##### 3.1. AMD / Intel

Generally, AMD and Intel drivers are supported by the Debian kernel, but we ensure their installation anyway:

    sudo apt install -y firmware-amd-graphics mesa-vulkan-drivers mesa-va-drivers vainfo
    sudo apt install -y intel-media-va-driver firmware-misc-nonfree mesa-va-drivers vainfo

##### 3.2. NVIDIA

First, install the NVIDIA detection tool and run it:

    sudo apt install -y nvidia-detect
    sudo nvidia-detect

It will recommend the proper driver to install:

    sudo apt install -y [driver]

Alternatively, install all NVIDIA drivers:

    sudo apt install nvidia-driver firmware-misc-nonfree nvidia-settings

Reboot the system and verify the installation:

    sudo reboot
    nvidia-smi


## 🚀 Installation

Proceed to install the Debian 12 GNU/Linux setup program.

#### 1. Clone the repository

    git clone https://github.com/oritp/debian-setup.git
    cd debian-setup

#### 2. Grant execution permissions

    chmod +x setup.sh

#### 3. Run the main script

    ./setup.sh


## 📋 Menu Options

When executing the script, an interactive menu will appear with the following options:

- Install everything
- Install only essential configuration
- Install only appearance configuration
- Install only terminal configuration
- Install only VS Code
- Install only Spotify


## 📊 Details of `essentials.sh`

This script automates the installation of a base setup ideal for desktop and development environments. With this setup, the system is ready to be fully used.

Here are the processes included in the essential setup:

- **System update and enabling backports**

Improves compatibility and updates the system to the latest available version with backports.

- **Installation of essential tools**

Installs CLI utilities for networking, editors (vim, nano), monitoring (neofetch, htop, btop, inxi), download and control tools (curl, wget, git, gpg), certificates and software common properties.

- **Package managers and decompression tools**

Installs drivers for file systems and compression formats (exFAT, HFS, NTFS, ZIP, RAR, 7ZIP), as well as package managers (Synaptic, Gdebi, Flatpak).

- **Installation of CPU microcodes**

Analyzes the CPU and installs the appropriate microcodes for Intel or AMD based on the detected processor.

- **Development and network tools**

Installs useful tools for development (build-essential, gcc, g++, make, cmake, pkg-cofig, gdb, clang, python3) and network management (net-tools, iproute2, traceroute, tcpdump, whois, nmap).

- **Multimedia support and codecs**

Installs major codec packages for multimedia support (ffmpeg, gstreamer, libavcodec).

- **Fonts, printers, firewall, VPN and useful programs**

Installs text fonts (Microsoft, Ubuntu, free fonts), as well as printer drivers, a firewall (Gufw), a VPN (Riseup VPN), and finally useful programs (Kitty, Firefox, Chromium, GIMP, VLC, Audacity, Wireshark).

- **GNOME customization**

Installs tools to personalize the GNOME environment (gnome-tweaks, extensions tools, dconf-editor).

- **Final system cleanup**

At the end, the script frees up space and recommends a system reboot to apply all changes properly.


## 🎨 Details of `appearance.sh`

This script installs and enables a new look thanks to the GNOME Arc theme and Newaita icons.

It also installs some GNOME extensions and enables some pre-installed extensions for a more modern look.

Changes are attempted to be applied through _gsettings_, and if this isn't possible, you'll need to do it manually using the GNOME Tweaks GUI.

The maximize, minimize, and close buttons are also enabled in the top bar of application windows.

The extensions are as follows:

- Applications Menu (pre-intstalled)
- Places Status Indicator (pre-installed)
- User themes (pre-installed)
- Dash to dock
- Desktop Icons NG (DING)
- Vitals
- Logo Menu
- Blur My Shell

In order to apply the changes you will have to reboot GNOME Shell with `Alt+F2`, write `r` and press `Enter`, or log in again.


## 🖥️ Details of `terminal.sh`

This script configures the GNOME terminal emulator to create a more modern and attractive terminal that looks good with the new system appearance.

For those who prefer to use Kitty terminal, it can also be configured by using the `kitty.conf` file located in the same directory.

After finishing the installation of the new configuration, it is necessary to restart the terminal: `source ~/.bashrc`

Personally, I like a simple appearance and interface, with minimal clutter and a bit of transparency. Feel free to modify this script as you wish to suit your preferences.


## 🎵 Details of `vscode.sh` and `spotify.sh`

Thanks to these two scripts, we can install VS Code and Spotify applications from their official repositories.

It is very important to visit their official websites to keep the public keys updated before installation.

Once the public keys are verified, update the corresponding scripts if necessary.


## 👦 Author

This project was created by _@oritp_.

I hope you find it useful. Enjoy! :)
