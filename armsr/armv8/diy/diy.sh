#!/bin/bash

# Adjust source code
patch -p1 -f < $(dirname "$0")/luci.patch

# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
git clone https://github.com/Openwrt-Passwall/openwrt-passwall --depth=1 clone/passwall
git clone https://github.com/vernesong/OpenClash --depth=1 clone/openclash
git clone https://github.com/sbwml/luci-app-mosdns --single-branch --depth=1 clone/mosdns
git clone https://github.com/sbwml/packages_lang_golang --single-branch --depth=1 clone/golang
git clone https://github.com/sbwml/v2ray-geodata --depth=1 clone/v2ray-geodata

# Update packages
rm -rf feeds/luci/applications/luci-app-passwall feeds/luci/applications/luci-app-openclash feeds/packages/lang/golang feeds/packages/net/mosdns feeds/packages/net/v2ray-geodata
cp -rf clone/amlogic/luci-app-amlogic clone/passwall/luci-app-passwall clone/openclash/luci-app-openclash clone/mosdns/luci-app-mosdns feeds/luci/applications/
cp -rf clone/golang feeds/packages/lang/
cp -rf clone/mosdns/mosdns clone/mosdns/v2dat clone/my-pkg/haproxy clone/v2ray-geodata feeds/packages/net/
sed -i '/luci-app-attendedsysupgrade/d' feeds/luci/collections/luci/Makefile
sed -i 's/llvm=true/llvm=false/' feeds/packages/lang/rust/Makefile

# Clean packages
rm -rf clone
