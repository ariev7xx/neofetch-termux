#!/data/data/com.termux/files/usr/bin/bash

bashrc=$PREFIX/etc/bash.bashrc
if grep "neofetch" $bashrc
then
echo "neofetch already"
else
echo "installing neofetch"
apt install neofetch
sed '$ a\
> neofetch' $bashrc ;
fi
