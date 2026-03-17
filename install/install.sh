#!/bin/bash 


_path="$HOME/hypr-dots"
git_origin="https://github.com/sreelalv/hypr-dots"

[[ $(pacman -Qq git >/dev/null 2>&1) ]] || sudo pacman -S --needed git 
git clone $git_origin $_path 



if [[ ! $(command -v yay) && ! $(command -v paru) ]] ; then
	read -p "$(echo -e 'Please install an AUR helper.\n1. yay\n2. paru\nChoose ==> ')" -n 2 val 

	[[ $(pacman -Qq base-devel 2>/dev/null) ]] || sudo pacman -S --needed base-devel --noconfirm

	if [[ $val =~ ^[1] ]] ; then 
		echo -e "Installing yay-bin...\n"
		git clone https://aur.archlinux.org/yay-bin $HOME/yay-bin && \
			cd $HOME/yay-bin && \
			makepkg -si && \
			echo -e "yay-bin installed successfully \n" && \
			rm -rf $HOME/yay-bin 
	elif [[ $val =~ ^[2] ]] ; then 
		echo -e "Installing paru-bin...\n"
		git clone https://aur.archlinux.org/paru-bin $HOME/paru-bin && \
			cd $HOME/paru-bin && \
			makepkg -si && \
			echo -e "paru-bin Installed Successfully \n" && \
			rm -rf $HOME/paru-bin 
	fi
fi


install_app(){
    local app="$1"
    [[ $(pacman -Qq $app 2>/dev/null) ]] && echo -e "Already Installed - $app\n" || yay -S --needed $app --noconfirm || echo -e "App not Installed - $app\n" 
}

while IFS= read -r line; do 
	install_app $line ; 
done < $_path/install/pkg_list

DIR=($(find "$_path" -maxdepth 1 -type d -not -iname ".git" -exec basename {} \;))

for dirr in ${DIR[@]} ; do
	if [[ -d $_path/$dirr ]] ; then 	
		if [[ -d $HOME/.config/$dirr ]] ; then 
			mv "$HOME/.config/$dirr" "$HOME/.config/$dirr.bak"
			
		fi
		mv "$_path/$dirr" "$HOME/.config/$dirr"
	fi
done

[[ -d $HOME/.config/.git ]] && rm -rf "$HOME/.config/.git"
mv "$_path/.git" "$HOME/.config/.git"

[[ -f $HOME/.config/.gitignore ]] && rm "$HOME/.config/.gitignore"
mv "$_path/.gitignore" "$HOME/.config/.gitignore"

rm -rf "$_path"

hyprctl reload && ((hyprpaper >/dev/null 2>&1)&) && ((waybar >/dev/null 2>&1)&)

