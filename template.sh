#!/usr/bin/env bash

# Author      : Tomislav Miksa <tomislav.miksa@schindler.com>
# Date        : 2025-02-21
# Description : Install tcpdump tool on CB3/CB4 cubes
# Version     : 0.0.0

function err() {
   # function to write the error output
    1>&2 echo $*
}

function main() {
     # main function to run in the script
     echo -e "Starting the script..."
}

# running the main function
main "$@"
