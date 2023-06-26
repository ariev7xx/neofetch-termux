#!/data/data/com.termux/files/usr/bin/bash
echo "update repository.."
apt update -qqq
bashrc=$PREFIX/etc/bash.bashrc
if grep "neofetch" $bashrc
then
echo "neofetch already"
else
echo "installing neofetch"
apt install neofetch
apt install git
apt install perl
curl -O -s https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/bash.bashrc
cat bash.bashrc > $bashrc
rm bash.bashrc
fi
echo "installing font"
curl -O -s https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/font.ttf
mv font.ttf .termux/font.ttf
am broadcast --user 0 -a com.termux.app.reload_style com.termux >> /dev/null
source $bashrc
