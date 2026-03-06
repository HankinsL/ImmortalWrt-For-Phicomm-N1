#!/bin/bash

# Adjust source code
patch -p1 -f < $(dirname "$0")/luci.patch

# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
git clone https://github.com/Openwrt-Passwall/openwrt-passwall --depth=1 clone/passwall
git clone https://github.com/vernesong/OpenClash --depth=1 clone/openclash

# Update packages
rm -rf feeds/luci/applications/luci-app-passwall feeds/luci/applications/luci-app-openclash
cp -rf clone/amlogic/luci-app-amlogic clone/passwall/luci-app-passwall clone/openclash/luci-app-openclash feeds/luci/applications/

# Clean packages
rm -rf clone
