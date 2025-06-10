![Debian 12](https://img.shields.io/badge/Platform-Debian%2012-blue?logo=debian)
![Shell](https://img.shields.io/badge/Language-Shell-orange?logo=gnubash)
![License](https://img.shields.io/badge/License-MIT%20License-lightgrey)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

# Debian 12 GNU/Linux Setup

This repository contains a set of shell scripts designed to simplify the initial setup of systems based on Debian 12 GNU/Linux. It provides a quick and customizable installation of essential tools, development environments, system settings, appearance, and popular applications.

This is the repository structure:


## 🛠️ Preliminary Steps

Before running the main script, it is recommended to manually complete the following steps:

#### 1. Hide password input feedback

Access the _sudoers_ file located in the _etc_ system folder:

    su
    nano /etc/sudoers

Add the following line:

    Defaults pwfeedback

#### 2. Add superuser privileges

If our user (we'll call it _user_) does not come with predefined admin or superuser privileges, we can fix it by editing:

    nano /etc/sudoers

Scroll down to where users and permissions are listed, and add our user:

    user ALL=(ALL:ALL) ALL

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

    sudo apt install -y driver

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
-  Install only essential configuration
-  Install only terminal configuration
-  Install only appearance configuration
-  Install only VS Code
-  Install only Spotify


## 📊 Details of essentials.sh

This script automates the installation of a base setup ideal for desktop and development environments. With this setup, the system is ready to be fully used.

Here are the processes included in the essential setup:

- **System update and enabling backports**

Improves compatibility and updates the system to the latest available version.

- **Installation of essential tools**

Installs CLI utilities for networking, editors (vim), monitoring (htop, btop), download tools (curl, wget), certificates, and more.

- **Package managers and decompression tools**

Installs drivers for file systems and compression formats (exFAT, NTFS, zip, rar, 7z), as well as package managers (Synaptic, Gdebi, Flatpak).

- **Installation of CPU microcodes**

Analyzes the CPU and installs the appropriate microcodes for Intel or AMD based on the detected processor.

- **Development and network tools**

Installs useful tools for development and network management (build-essential, gcc, clang, python3, net-tools, traceroute, nmap, etc.).

- **Multimedia support and codecs**

Installs major codec packages for multimedia support (ffmpeg, GStreamer, etc.).

- **Fonts, printers, firewall and VPN**

Installs useful fonts like Microsoft and Ubuntu fonts, as well as printer drivers, a firewall (Gufw), and a VPN (Riseup VPN).

- **GNOME customization**

Installs tools to personalize the GNOME environment (gnome-tweaks, extensions, dconf-editor).

- **Final system cleanup**

At the end, the script frees up space and recommends a system reboot to apply all changes properly.


## 🖥️ Details of terminal.sh

In progress...


## 🎨 Details of appearance.sh

In progress...


## 🎵 Details of vscode.sh and spotify.sh

Thanks to these two scripts, we can install _VS Code_ and _Spotify_ from their official repositories.

It is very important to visit their official websites to keep the public keys updated before installation.

Once the public keys are verified, update the corresponding scripts if necessary.


## 👦 Author

This project was created by _@oritp_.

I hope you find it useful. Enjoy! :)
