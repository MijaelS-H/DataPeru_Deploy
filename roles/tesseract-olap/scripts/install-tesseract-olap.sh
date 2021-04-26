#!/bin/bash -eux

# download latest version from github
wget --quiet https://github.com/tesseract-olap/tesseract/releases/latest/download/tesseract-olap.deb

# Unpack with dpkg
dpkg --unpack tesseract-olap.deb

# Delete postinstall script
rm -f /var/lib/dpkg/info/tesseract-olap.postinst

# Configure package
dpkg --configure tesseract-olap

# To fix dependencies
apt-get install -yf

# Remove installation package
rm tesseract-olap.deb