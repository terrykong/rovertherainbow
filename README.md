# rovertherainbow

===
Setup:
```
sudo ./beacon_install.sh
```

===
Connecting to that device:
```
$ bluetoothctl
# inside bluetooth CLI
agent on
default-agent
scan on #to find mac address
scan off #once the mac address comes up
pair <mac address>
connect <mac address>
trust <mac address>
exit
# Back in terminal
$ hcitool rssi <mac address>
```

===
Troubleshooting:
If you have wifi problems, disabling power management may help
http://www.thelowercasew.com/disabling-wifi-power-management-permanently-for-raspberry-pi-3-with-raspbian-jessie

