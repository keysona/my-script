# My scripts.

## ss一键安装脚本

仅针对debain/ubuntu，digitalocean的机子测试通过。(ubuntu 14.04 | debain 7)

### 如何使用?
```shell
apt-get install curl
curl 'https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/ss%E4%B8%80%E9%94%AE%E8%84%9A%E6%9C%AC.sh' > /tmp/ss.sh && bash /tmp/ss.sh && rm /tmp/ss.sh
```

根据机子的性能，花费的时间3-10分钟。
digitalocean ubuntu14.04 512mb内存 花费5分钟。

### 特点:
- 支持chacha20
- 默认端口是443
- 用supervisor管理,开机/重启自动开启ss
```shell
# 管理shadowsocks
supervisorctl start shadowsocks
supervisorctl stop shadowsocks
supervisorctl restart shadowsocks
```
- 自动生成高强度密码，shadowsocks的配置文件在```/etc/shadowsocks.json```
- 完成后显示相应的配置文件: 服务器ip，端口，密码等。
```shell
# 默认单用户配置显示的配置文件
{
    "server":"100.100.100.100",
    "server_port":443,
    "local_port":1080,
    "password":"35cc8c0bf8810a1ddc2b86b0cb80b1f5",
    "timeout":300,
    "method":"chacha20"
}
```

```shell
# 多用户配置文件
{
            "server":"0.0.0.0",
            "local_address":"127.0.0.1",
            "local_port":1080,
            "port_password":{
                               "2333":"fjlag;l556",
                               "6666":"jgaingga"
                           },
              "_comment":{
                                 "2333":"whouse",
                                 "6666":"whouse"
                            },
            "timeout":300,
            "method":"chacha20",
            "fast_open": false
}
```

- 已完成内核参数的优化，默认优化算法是针对高延迟地区的hybla

## ss-script

**Only for debain/ubuntu. Test pass in digitalocean(ubuntu 14.04 | debain 7)**

### How to use?

```shell
apt-get install curl
curl 'https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/ss%E4%B8%80%E9%94%AE%E8%84%9A%E6%9C%AC.sh' > /tmp/ss.sh && bash /tmp/ss.sh && rm /tmp/ss.sh
```
### Features
- **Support chacha20.**
- **Default port is 443.**
- **Automatically generate password.**
- **Supervisor managment, auto start when vps  start or restart.**
- **The location of Shadowsocks config file is ```/etc/shadowsocks.json```.**
- **When finished, will atuo print the client config file.**
```shell
# client config file
{
    "server":"100.100.100.100",
    "server_port":443,
    "local_port":1080,
    "password":"35cc8c0bf8810a1ddc2b86b0cb80b1f5",
    "timeout":300,
    "method":"chacha20"
}
```

## 替换内核以支持破解版锐速 
1.安装内核文件：
```
sudo apt-get install linux-image-extra-3.13.0-29-generic
```
2.查看当前安装的内核：
```
dpkg -l|grep linux-image
```
3.卸载其他内核：
```
sudo apt-get purge linux-image-3.13.0-xx-generic linux-image-extra-3.13.0-xx-generic
```
4.更新grub系统引导文件：
```
sudo update-grub
```
5.重启系统：
```
sudo reboot
```
6.安装破解版锐速
```
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh
```
所有选项一路回车，选择默认即可。
