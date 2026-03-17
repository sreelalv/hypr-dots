#!/bin/bash


dir="$HOME/Pictures/wallpapers"
choice=$(find "$dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | 
         while read img; do echo -en "$img\0icon\x1f$img\n"; done | 
         rofi -dmenu -i -p "Select Wallpaper " -theme $HOME/.config/rofi/wallpaper.rasi )

echo "$choice"
[ -n "$choice" ] && ln -sf "$choice" "$dir/.current_wallpaper" && pkill hyprpaper && ((hyprpaper >/dev/null 2>&1)&) 
