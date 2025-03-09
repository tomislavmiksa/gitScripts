#!/usr/bin/env bash

# Author      : Tomislav Miksa <tomislav.miksa@schindler.com>
# Date        : 2025-02-21
# Description : Install tcpdump tool on CB3/CB4 cubes
# Version     : 0.0.0

REPOFILE="/etc/apt/sources.list.d/buster.list"

# function to write the error log
function err() {
    1>&2 echo $*
}

# function to add public buster repo on the cube
function doRepo() {
    echo -e "Adding public buster repo to the device"
    sudo touch $1
    sudo chmod 777 $1
    cat >> $1<< EOF
deb https://deb.debian.org/debian buster main contrib non-free
deb https://deb.debian.org/debian buster-updates main contrib non-free
deb https://archive.debian.org/debian buster-backports main contrib non-free
deb http://security.debian.org/ buster/updates main contrib non-free
 
deb-src https://deb.debian.org/debian buster main contrib non-free
deb-src https://deb.debian.org/debian buster-updates main contrib non-free
deb-src https://archive.debian.org/debian buster-backports main contrib non-free
deb-src http://security.debian.org/ buster/updates main contrib non-free
EOF

    echo -e "Updating the repositories"
    sudo apt-get update
}

# function to remove the public repositories from the cube
function dontRepo() {
    # remove the repository files
    sudo rm -rf $REPOFILE
    sudo apt-get update
}

# function to update the repositories and install tcpdump package
function installTcpDump() {
    echo -e "installing the tcpdump software"
    sudo apt-get install tcpdump
}

# MAIN function which will run
function main() {
     echo -e "Starting the install tcpdump script..."
     doRepo $REPOFILE
     installTcpDump
     #dontRepo $REPOFILE
}

# MAIN PROGRAM CALL
# -------------------------------------------------------------------------------
main "$@"
