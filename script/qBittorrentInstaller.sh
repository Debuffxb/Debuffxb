#! /bin/sh
apt update
apt -y upgrade
apt install -y sudo htop screen iftop sysstat
apt install -y build-essential pkg-config automake libtool git zlib1g-dev libssl-dev libgeoip-dev libboost-dev libboost-system-dev libboost-chrono-dev libboost-random-dev
apt install -y qtbase5-dev qttools5-dev libqt5svg5-dev
git clone https://github.com/arvidn/libtorrent.git
cd libtorrent
git checkout libtorrent-1_2_5
./autotool.sh
./configure --disable-debug --enable-encryption CXXFLAGS="-std=c++14"
make clean && make -j$(nproc)
make install
ln -s /usr/local/lib/libtorrent-rasterbar.so.10 /usr/lib/libtorrent-rasterbar.so.10
cd ../
git clone https://github.com/qbittorrent/qBittorrent
cd qBittorrent
git checkout release-4.2.5
./configure CXXFLAGS="-std=c++14" --disable-gui
make -j$(nproc)
make install
cd ../
rm -r qBittorrent
rm -r libtorrent
