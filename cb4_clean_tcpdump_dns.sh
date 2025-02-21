#!/usr/bin/env bash

# Author      : Tomislav Miksa <tomislav.miksa@schindler.com>
# Date        : 2025-02-21
# Description : Cleanup tcpdump tool on CB3/CB4 cubes
# Version     : 0.0.0

function err() {
   # function to write the error output
    1>&2 echo $*
}

function main() {
     # main function to run in the script
     echo -e "Starting the script..."
     sudo rm /etc/systemd/system/dnsdebug.service
     sudo systemctl stop dnsdebug
     sudo systemctl disable dnsdebug
     sudo systemctl daemon-reload
}

# running the main function
main "$@"
