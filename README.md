#Install tmux
sudo apt install tmux

#Install ZSH
sudo apt install zsh

#Make ZSH your default shell
chsh -s $(which zsh)

#Test shell (optional)
echo $SHELL

#Install Oh My ZSH

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Install PowerLevel10k

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

#Install nerdfonts

###No script - just download from this repo and install

#Download plugins for autosuggestion and syntax highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

#Delete current .zshrc and .p10k.conf files and download updated configuration files
rm .zshrc
rm .p10k.conf

wget https://raw.githubusercontent.com/billfasoli/linuxboxsetup/main/.zshrc

wget https://raw.githubusercontent.com/billfasoli/linuxboxsetup/main/.zshrc

wget https://raw.githubusercontent.com/billfasoli/linuxboxsetup/main/.nanorc

wget https://raw.githubusercontent.com/billfasoli/linuxboxsetup/main/.tmux.conf

#reboot
