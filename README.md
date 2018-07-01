# rovertherainbow

===
Setup:
```
sudo ./beacon_install.sh
```

===
Connecting to that device:
```
sudo rfcomm connect 0 "$(cat default_device | cut -f1)" 10 >/dev/null &
```

===
Troubleshooting:
If you have wifi problems, disabling power management may help
http://www.thelowercasew.com/disabling-wifi-power-management-permanently-for-raspberry-pi-3-with-raspbian-jessie

