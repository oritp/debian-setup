#!/bin/bash

# Colors
RED='\e[0;31m'
BLUE='\e[0;34m'
CYAN='\e[0;36m'
AUTO='\e[0m'

# Functions
title() { echo -e "${BLUE}$1${AUTO}"; }
print() { echo -e "${CYAN}$1${AUTO}"; }
error() { echo -e "${RED}$1${AUTO}"; }
