#! /bin/sh
echo -n 'server:'
read server
echo 'server:'$server
echo 'Enter to continue, Ctrl+C to exit:'
read
if [ -f "./suzaku" ]; then
rm speedtest
fi
echo " 开始下载 suzaku client"
wget -q "https://raw.githubusercontent.com/Debuffxb/Debuffxb/main/bin/client"
mkdir '/usr/local/suzaku'
mv client '/usr/local/suzaku/'
chmod +x '/usr/local/suzaku/client'
echo " 添加 systemd 文件 "
echo '[Unit]
Description=suzaku service
After=network.target
[Service]
Type=simple
Restart=always
ExecStart=/usr/local/suzaku/client -c "*/10 * * * * *" -s "'$server'"
PrivateTmp=true
[Install]
WantedBy=multi-user.target' > '/etc/systemd/system/suzaku.service'
echo " 启动进程 "
systemctl enable suzaku
service suzaku start
