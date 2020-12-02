#! /bin/sh
if [ -f "./speedtest" ]; then
rm speedtest
fi
echo "开始下载 speedtest"
wget -q "https://raw.githubusercontent.com/Debuffxb/Debuffxb/main/bin/speedtest"
