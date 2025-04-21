#!/data/data/com.termux/files/usr/bin/bash
cd
echo "update repository.."
apt update -qqq
bashrc=$PREFIX/etc/bash.bashrc
if grep "neofetch" $bashrc &> /dev/null
then
echo "neofetch already install in bashrc"
else
echo "installing neofetch..."
apt install neofetch git perl -y &> /dev/null
curl -O -s https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/bash.bashrc
cp $bashrc bash.bashrc.bak
cat bash.bashrc > $bashrc
rm bash.bashrc
rm $PREFIX/etc/motd
echo "neofetch --ascii_distro arch_small" > $PREFIX/etc/profile.d/motd.sh
chmod +x $PREFIX/etc/profile.d/motd.sh
echo "installing font...."
curl -O -s https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/font.ttf
mv font.ttf .termux/font.ttf
am broadcast --user 0 -a com.termux.app.reload_style com.termux >> /dev/null
fi
rm i.sh
echo "please restart termux"
read
exit
