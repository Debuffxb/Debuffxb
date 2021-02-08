#! /bin/sh
echo -n 'server:'
read server
echo -n 'client name:'
read name
echo -n 'client id:'
read id
echo 'server:'$server
echo 'client name:'$name
echo 'client id:'$id
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
ExecStart=/usr/local/suzaku/client -c "*/10 * * * * *" -s "'$server'" -i "'$id'" -n "'$name'"
PrivateTmp=true
[Install]
WantedBy=multi-user.target' > '/etc/systemd/system/suzaku.service'
echo " 启动进程 "
systemctl enable suzaku
service suzaku start
