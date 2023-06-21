#!/data/data/com.termux/files/usr/bin/bash
rm neofetch.sh
bashrc=$PREFIX/etc/bash.bashrc
if grep "neofetch" $bashrc
then
echo "neofetch already"
else
echo "installing neofetch"
apt install neofetch
sed -i '$a  neofetch --ascii_distro arch_small' $bashrc ;
sed -i '1i clear' $bashrc ;
rm neofetch.sh
fi
