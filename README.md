# Tron: Legacy Hyprland Setup 🖥️

My personal Arch Linux + Hyprland dotfiles.

## 📸 Preview
<!-- Add a screenshot of your desktop here -->

## 🧰 What's Inside

| Config | Purpose |
|--------|---------|
| `hypr/` | Hyprland compositor, hypridle, hyprlock, wallpaper scripts |
| `waybar/` | Status bar |
| `kitty/` | Terminal emulator |
| `rofi/` | App launcher |
| `eww/` | Desktop widgets |
| `btop/` | System monitor |
| `mpv/` | Media player |
| `gtk-3.0/` & `gtk-4.0/` | GTK theming |
| `.zshrc` | Zsh shell config |
| `.p10k.zsh` | Powerlevel10k prompt theme |

## ⚙️ Dependencies
- Hyprland, Waybar, Kitty, Zsh, Oh My Zsh, Powerlevel10k
- Rofi, Eww, Swww, Swaync, Hypridle, Hyprlock, Cliphist

## 🚀 Restoring on a Fresh Machine
1. Install Arch + dependencies via pacman/yay
2. Clone this repo:
   git clone https://github.com/TodScissorhands/dotfiles.git
3. Copy configs:
   cp -r dotfiles/.config/* ~/.config/
   cp dotfiles/.zshrc ~/
   cp dotfiles/.p10k.zsh ~/

## 🔄 Keeping It Updated
cd ~/dotfiles
git add .
git commit -m "describe your change"
git push
