#!/usr/bin/env bash

# Author      : Tomislav Miksa <tomislav.miksa@schindler.com>
# Date        : 2025-02-21
# Description : Creating DNS service to collect the DNS records sent and store them in the /tmp/dnsrecords.log
# Version     : 0.0.0

DNSSVCS="/etc/systemd/system/dnsdebug.service"
DNSDUMP="/tmp/dnsrecords.pcap"

function err() {
   # function to write the error output
    1>&2 echo $*
}

# function to create the dns service
function createServiceDnsMonitoring() {
    echo -e "Creating the DNS Service File..."
    sudo touch $1
    sudo chmod 777 $1
    cat >> $1<< EOF
# LOCATION: /etc/systemd/system
# NAME    : dnsdebug.service
[Unit]
Description="This service is there to get the DNS requests logs"

[Service]
User=root
WorkingDirectory=/home/cb4adm/
ExecStart=tcpdump -n -w $DNSDUMP -i any port 53
# optional items below
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
}

function main() {
     # main function to run in the script
     createServiceDnsMonitoring $DNSSVCS
     sudo systemctl daemon-reload
     sudo systemctl status dnsdebug
     sudo systemctl enable dnsdebug
}

# running the main function
main "$@"
