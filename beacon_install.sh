#!/bin/bash

set -eou pipefail

if ! [ $(id -u) = 0 ]; then
   echo "This needs to be run as root"
   exit 1
fi

# A setup file to remember the installation steps to connect rpi to phone via bluetooth
# Following: https://www.raspberrypi.org/forums/viewtopic.php?t=47466

# Installs bluetooth stack
apt install -y --no-install-recommends bluetooth

# Find bluetooth ID from list of acceptable device names and pick the first one
echo "-----------------------------------------------------------------------------"
echo "Scanning..."
devices_found="$(hcitool scan | tail -n+2 | awk '{print "[" NR "]" "\t" $0}')"
num_devices_found=$(echo "$devices_found" | wc -l)
while [[ $(echo "$devices_found" | cut -f4 | fgrep 'n/a' | wc -l) -gt 0 ]]; do
  devices_found="$(hcitool scan | tail -n+2 | awk '{print "[" NR "]" "\t" $0}')"
  num_devices_found=$(echo "$devices_found" | wc -l)
done
if [[ $num_devices_found -eq 0 ]]; then
  echo "Couldn't find any devices. Please make your device visible and try again"
  exit 1
fi
echo "$devices_found"
read -p "Please select one of the above devices by number[if you don't see yours then ctrl+c]: " SELECTION
while [[ ! $SELECTION =~ ^-?[0-9]+$ ]] || [[ "$SELECTION" -le 0 ]] || [[ "$SELECTION" -gt $num_devices_found ]]; do 
  [[ $SELECTION =~ ^-?[0-9]+$ ]] && echo '[[ '$SELECTION' =~ ^-?[0-9]+$ ]]'
  [[ "$SELECTION" -le 0 ]] && echo "[[ "$SELECTION" -le 0 ]]"
  [[ "$SELECTION" -gt $num_devices_found ]] && echo "[[ "$SELECTION" -gt $num_devices_found ]]"
  read -p "Unrecognized value, try again: " SELECTION
done
BLUETOOTH_ADDRESS=$(echo "$devices_found" | tail -n+$SELECTION | head -n1 | cut -f3)
BLUETOOTH_DEVICE_NAME=$(echo "$devices_found" | tail -n+$SELECTION | head -n1 | cut -f4)
echo "Using device address=$BLUETOOTH_ADDRESS | name=\"$BLUETOOTH_DEVICE_NAME\""
echo -e "${BLUETOOTH_ADDRESS}\t${BLUETOOTH_DEVICE_NAME}" > default_device

