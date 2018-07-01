#!/bin/bash

# Based off of http://www.thelowercasew.com/disabling-wifi-power-management-permanently-for-raspberry-pi-3-with-raspbian-jessie

set -eou pipefail

if ! [ $(id -u) = 0 ]; then
   echo "This needs to be run as root"
   exit 1
fi

SCRIPT_NAME=disable_wifi_power_management.sh
SERVICE_NAME=disable_wifi_power_management

echo -e '#!/bin/sh -\niwconfig wlan0 power off' > $HOME/$SCRIPT_NAME
chmod a+x $HOME/$SCRIPT_NAME

echo "[Unit]
Description=$SERVICE_NAME
After=multi-user.target
 
[Service]
Type=idle
ExecStart=$HOME/$SCRIPT_NAME
 
[Install]
WantedBy=multi-user.target" > /lib/systemd/system/${SERVICE_NAME}.service

chmod 644 /lib/systemd/system/${SERVICE_NAME}.service
systemctl daemon-reload
systemctl enable ${SERVICE_NAME}.service

echo "Will reboot in 10 sec, cancel with ctrl+c"
sleep 10 && reboot

