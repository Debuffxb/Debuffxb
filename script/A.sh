#! /bin/bash
t=$(cat /etc/vim/vimrc.tiny | grep nocompatible | wc -l)
if [ $t -eq 0 ]; then
  echo vim
  sed -i "s/compatible/nocompatible/g" /etc/vim/vimrc.tiny
  echo 'set backspace=2' >> /etc/vim/vimrc.tiny
fi
apt update
apt -y upgrade
apt install -y git gcc htop screen net-tools sysstat
