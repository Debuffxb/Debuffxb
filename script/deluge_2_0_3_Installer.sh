#! /bin/sh
apt update
apt -y upgrade
apt install -y git gcc
apt install -y python python-twisted python-openssl python-setuptools intltool python-xdg python-chardet geoip-database python-libtorrent python-notify python-pygame python-glade2 librsvg2-common xdg-utils python-mako
apt install -y python-pip  build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev python-dev
pip install pillow
apt install -y libboost-dev libboost-system-dev libboost-chrono-dev libboost-random-dev
apt install -y libtool
git clone https://github.com/arvidn/libtorrent.git
cd libtorrent
git checkout libtorrent-1_2_5
./autotool.sh
./configure --disable-debug --enable-encryption CXXFLAGS="-std=c++14"
make clean && make -j$(nproc)
make install
ln -s /usr/local/lib/libtorrent-rasterbar.so.10 /usr/lib/libtorrent-rasterbar.so.10
cd ../
rm libtorr* -r
git clone git://deluge-torrent.org/deluge.git
cd deluge
git reset b711cd258ae3001d5f1aa69617c22a2d258b1c06
python setup.py build
python setup.py install --install-layout=deb
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
ExecStart=/usr/bin/deluge-web -f

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/deluge-web.service
