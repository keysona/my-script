#!/bin/bash

# install shadowsocks
apt-get update
apt-get install -y -qq python-pip python-m2crypto supervisor
pip install shadowsocks

# install libsodium to support chacha20
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar zxf LATEST.tar.gz
cd libsodium*
./configure
make && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig

# default port is 443
SS_PASSWORD=`dd if=/dev/urandom bs=32 count=1 | md5sum | cut -c-32`
SS_PORT=443 #`seq 1025 9000 | grep -v -E "$PORTS_USED" | shuf -n 1`

# get config file
wget https://raw.githubusercontent.com/shadowsocks/stackscript/master/shadowsocks.json -O /etc/shadowsocks.json
wget https://raw.githubusercontent.com/shadowsocks/stackscript/master/shadowsocks.conf -O /etc/supervisor/conf.d/shadowsocks.conf
wget https://raw.githubusercontent.com/shadowsocks/stackscript/master/local.conf -O /etc/sysctl.d/local.conf

# optimize shadowsocks
sysctl --system

# change port and password
sed -i -e s/SS_PASSWORD/$SS_PASSWORD/ /etc/shadowsocks.json
sed -i -e s/SS_PORT/$SS_PORT/ /etc/shadowsocks.json

# reload supervisor
service supervisor stop
echo 'ulimit -n 51200' >> /etc/default/supervisor
service supervisor start
supervisorctl reload

# all finish
echo "Restart shadowsocks: supervisorctl restart shadowsocks"
echo "You password: $SS_PASSWORD"
