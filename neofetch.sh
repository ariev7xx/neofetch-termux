#!/data/data/com.termux/files/usr/bin/bash
apt update
bashrc=$PREFIX/etc/bash.bashrc
if grep "neofetch" $bashrc
then
echo "neofetch already"
else
echo "installing neofetch"
apt install neofetch
apt install git
curl -O https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/bash.bashrc
echo $HOME/bash.bashrc > $bashrc
fi
