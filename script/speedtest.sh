#! /bin/sh
if [ -f "./speedtest" ]; then
rm speedtest
fi
echo "开始下载 speedtest"
wget -q "https://raw.githubusercontent.com/Debuffxb/Debuffxb/main/bin/speedtest"
mkdir '/usr/local/speedtest'
mv speedtest '/usr/local/speedtest/'
echo "添加 systemd 文件"
echo '[Unit]
Description=speedtest service
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=/usr/local/speedtest/speedtest
PrivateTmp=true

[Install]
WantedBy=multi-user.target' > '/etc/systemd/system/speedtest.service'
echo "添加防火墙规则"
iptables -I INPUT -p tcp --dport 15239 -j ACCEPT
echo "启动进程"
systemctl enable speedtest
service speedtest start