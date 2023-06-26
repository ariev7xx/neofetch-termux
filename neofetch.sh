#!/data/data/com.termux/files/usr/bin/bash
apt update
if grep "neofetch" $bashrc
then
echo "neofetch already"
else
echo "installing neofetch"
apt install neofetch
apt install git
curl -O https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/bash.bashrc
cat bash.bashrc > $bashrc
rm bash.bashrc
fi
echo "installing font"
curl -O https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/font.ttf >> /dev/null
mv font.ttf .termux/font.ttf
am broadcast --user 0 -a com.termux.app.reload_style com.termux >> /dev/null
login
