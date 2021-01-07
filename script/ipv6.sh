#! /bin/sh
echo -n 'DUID:'
read DUID
echo -n 'IPv6 Address:'
read ADDR
echo -n 'Prefix Length:'
read PREFIXLENGTH
echo -n 'interface:'
read INTERFACE
echo 'DUID:'$DUID
echo 'address:'$ADDR
echo 'prefixlength'$PREFIXLENGTH
echo 'interface:'$INTERFACE
echo 'Enter to continue, Ctrl+C to exit:'
read
echo 'interface "'$INTERFACE'" {
   send dhcp6.client-id '$DUID';
}' > /etc/dhcp/dhclient6.conf
echo '[Unit]
Description=dhclient for sending DUID IPv6
After=network-online.target
Wants=network-online.target

[Service]
Restart=always
RestartSec=10
Type=forking
ExecStart=/sbin/dhclient -cf /etc/dhcp/dhclient6.conf -6 -P -v eno1
ExecStop=/sbin/dhclient -x -pf /var/run/dhclient6.pid

[Install]
WantedBy=network.target' > /etc/systemd/system/dhclient.service
systemctl enable dhclient.service
echo 'auto '$INTERFACE'
iface '$INTERFACE' inet6 static
    address '$ADDR'
    netmask '$PREFIXLENGTH >> /etc/network/interfaces
echo OK!
