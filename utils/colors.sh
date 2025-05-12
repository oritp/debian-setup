#!/bin/bash

# Colors
RED='\e[0;31m'
CYAN='\e[0;36m'
AUTO='\e[0m'

# Functions
print() { echo -e "${CYAN}$1${AUTO}"; }
error() { echo -e "${RED}$1${AUTO}"; }
