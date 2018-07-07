#!/bin/bash

# Followed https://www.waveshare.com/wiki/3.5inch_RPi_LCD_(A)
# LCD bought here: https://www.amazon.com/gp/product/B01IGBDT02/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1

wget https://www.waveshare.com/w/upload/3/34/LCD-show-180331.tar.gz
tar xvf LCD-show-*.tar.gz
cd LCD-show/
chmod +x LCD35-show
./LCD35-show

sudo apt-get install -y xinput-calibrator
echo -e '

Now to calibrate go to Menu > Preferences > Calibrate Touchscreen

'

