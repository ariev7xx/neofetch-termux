# installasi
**Install neofetch untuk termux**
```bash 
curl -so i.sh https://raw.githubusercontent.com/ariev7xx/neofetch-termux/main/neofetch.sh && chmod +x i.sh && ./i.sh
```
# oh-my-zsh

install

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

plugin oh-my-zsh

```bash
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' .zshrc
```
