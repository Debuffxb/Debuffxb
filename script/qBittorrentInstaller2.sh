#! /bin/sh
apt update
apt -y upgrade
apt install -y sudo htop screen iftop sysstat
apt install -y build-essential pkg-config automake libtool git zlib1g-dev libssl-dev libgeoip-dev libboost-dev libboost-system-dev libboost-chrono-dev libboost-random-dev
apt install -y qtbase5-dev qttools5-dev libqt5svg5-dev libtorrent-dev libtorrent-rasterbar-dev
git clone https://github.com/qbittorrent/qBittorrent
cd qBittorrent
git checkout release-4.2.5
./configure CXXFLAGS="-std=c++14" --disable-gui
make -j$(nproc)
make install
cd ../
rm -r qBittorrent
rm -r libtorrent
echo '[Unit]
Description=qBittorrent-nox
After=network.target
[Service]
User=root
Type=forking
RemainAfterExit=yes
LimitNOFILE=100000
ExecStart=/usr/local/bin/qbittorrent-nox -d
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/qbittorrent-nox.service
