# My scripts.

## ss-script

仅针对debain/ubuntu，digitalocean的机子测试通过。(ubuntu 14.04/16.04 | debain 7)

如何使用?
```shell
apt-get install curl
curl 'https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/ss%E4%B8%80%E9%94%AE%E8%84%9A%E6%9C%AC.sh' > /tmp/ss.sh && bash /tmp/ss.sh && rm /tmp/ss.sh
```

特点:
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
# 显示的配置文件
{
    "server":"100.100.100.100",
    "server_port":443,
    "local_port":1080,
    "password":"35cc8c0bf8810a1ddc2b86b0cb80b1f5",
    "timeout":300,
    "method":"chacha20"
}
```
- 已完成内核参数的优化，默认优化算法是针对高延迟地区的hybla

**Only for debain/ubuntu. Test pass in digitalocean(ubuntu 14.04/16.04 | debain 7)**

**How to use?**

```shell
apt-get install curl
curl 'https://raw.githubusercontent.com/keysona/my-script/master/shadowsocks/ss%E4%B8%80%E9%94%AE%E8%84%9A%E6%9C%AC.sh' > /tmp/ss.sh && bash /tmp/ss.sh && rm /tmp/ss.sh
```

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
