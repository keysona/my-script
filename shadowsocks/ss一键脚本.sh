#!/bin/bash

# default port is 443
SS_SERVER_IP=`curl ipecho.net/plain`
SS_PORT=443 #`seq 1025 9000 | grep -v -E "$PORTS_USED" | shuf -n 1`
SS_PASSWORD=`dd if=/dev/urandom bs=32 count=1 | md5sum | cut -c-32`

# install shadowsocks
apt-get update
apt-get install -y -qq python-pip python-m2crypto supervisor
pip install shadowsocks

# install libsodium to support chacha20
echo 'Download and install chacha20'
wget -q https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar zxf LATEST.tar.gz
cd libsodium*
./configure
make && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig

# get config file
echo 'Download config file'
wget -q https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/shadowsocks.json -O /etc/shadowsocks.json
wget -q https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/shadowsocks.conf -O /etc/supervisor/conf.d/shadowsocks.conf
wget -q https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/local.conf -O /etc/sysctl.d/local.conf
wget -q https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/shadowsocks-client.json -O /tmp/client.json

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
echo "Your client config file:"
cat /tmp/client.json | sed -r -e "s/SS_SERVER_IP/$SS_SERVER_IP/" -e "s/SS_PORT/$SS_PORT/" -e "s/SS_PASSWORD/$SS_PASSWORD/"
rm /tmp/client.json
