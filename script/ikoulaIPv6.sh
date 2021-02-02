#! /bin/sh
echo -n 'IPv4:'
read IPv4
echo -n 'interface:'
read INTER
echo 'IPv4:'$IPv4
echo 'interface:'$INTER
echo 'Enter to continue, Ctrl+C to exit:'
read
gateway=${IPv4%.*}
echo 'iface '$INTER' inet6 static
  address 2a00:c70:1:'${IPv4//./:}':1
  netmask 96
  gateway 2a00:c70:1:'${gateway//./:}'::1' >> /etc/network/interfaces
