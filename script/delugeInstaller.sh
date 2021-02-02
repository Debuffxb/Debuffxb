#! /bin/sh
apt update
apt -y upgrade
apt install -y deluged deluge-web
systemctl stop deluged
rm /etc/init.d/deluged
systemctl daemon-reload
echo 添加deluged.service
echo '[Unit]
Description=deluged
After=network.target

[Service]
User=root
Type=forking
RemainAfterExit=yes
LimitNOFILE=100000
ExecStart=/usr/bin/deluged

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/deluged.service
echo 添加deluge-web.service
echo '[Unit]
Description=deluge-web
After=network.target

[Service]
User=root
Type=forking
RemainAfterExit=yes
LimitNOFILE=100000
ExecStart=/usr/bin/deluge-web

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/deluge-web.service
