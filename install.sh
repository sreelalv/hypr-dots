#!/bin/bash


newline(){
	echo -e "\n"
}
install_app(){
    local app="$1"
    pacman -Qq $app &>/dev/null || sudo pacman -S --needed $app --noconfirm || yay -S $app --noconfirm || echo "$app not installed" 
}

read -p "Do you want to install hyprland Dots [y/n]" -n 1 val1 ; 
read -p "$(echo -e '\nDo you want to install bash Terminal Dots [y/n]')" -n 1 val2 ; 
newline


pacman -Qq yay-bin &>/dev/null || pacman -Qq paru &>/dev/null || read -p "$(echo -e '\nInstall an Aur Helper. \n1. yay \n2. paru \nChoose 1 or 2 => ')" -n 1 aur
    if [[ $aur = '1' ]] ; then 
        newline && git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin && newline
        cd ~/yay-bin && makepkg -si && rm -rf ~/yay-bin >/dev/null 2>&1
    elif [[ $aur = '2' ]] ; then 
        newline && git clone https://aur.archlinux.org/paru.git ~/paru && newline
        cd ~/paru && makepkg -si  && rm -rf ~/paru >/dev/null 2>&1
    fi

apps=("base-devel" "git" "hyprpaper" "hyprlock" "wofi" "waybar" "thunar" "brave-bin" "telegram-desktop" "rsync" "brightnessctl" "less" "dosfstools" "net-tools" "vim" "openssh" "rsync")
for _app in "${apps[@]}" ; do 
    install_app $_app
done


if [[ $val1 =~ ^[Yy]$ ]]; then  
    [ -d ~/.config/hypr ]  && mv ~/.config/hypr ~/.config/hypr-backup 
    newline && git clone https://github.com/sreelalv/hypr-dots.git ~/.config/hypr 
    
    [ -d ~/helper-scripts ] && mv ~/.helper-scripts-backup 
    newline && git clone https://github.com/sreelalv/helper-scripts ~/helper-scripts
fi 

if [[ $val2 =~ ^[Yy]$ ]]; then 
    source <(curl -fsSL "https://raw.githubusercontent.com/sreelalv/dotfiles/refs/heads/master/install")
fi 


