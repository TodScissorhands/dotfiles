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
| `fontconfig/` | Font rendering |
| `nwg-look/` | GTK theme manager |
| `xsettingsd/` | X settings |
| `.zshrc` | Zsh shell config |
| `.p10k.zsh` | Powerlevel10k prompt theme |

## ⚙️ Dependencies

- **WM**: Hyprland
- **Bar**: Waybar
- **Terminal**: Kitty
- **Shell**: Zsh + Oh My Zsh + Powerlevel10k
- **Launcher**: Rofi
- **Widgets**: Eww
- **Wallpaper**: Swww
- **Notifications**: Swaync
- **Idle/Lock**: Hypridle + Hyprlock
- **Clipboard**: Cliphist

## 🚀 Restoring on a Fresh Machine

1. Install Arch Linux and the dependencies above via `pacman` / `yay`
2. Clone this repo:
   ```bash
   git clone https://github.com/TodScissorhands/dotfiles.git
   ```
3. Copy configs into place:
   ```bash
   cp -r dotfiles/.config/* ~/.config/
   cp dotfiles/.zshrc ~/
   cp dotfiles/.p10k.zsh ~/
   ```
4. Install Oh My Zsh and Powerlevel10k, then restart your shell

## 🔄 Keeping It Updated

After making changes to your configs:
```bash
cd ~/dotfiles
git add .
git commit -m "describe your change"
git push
```
