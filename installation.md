# NOTE
assuming you install from endeavour, that will not come with kitty by default.
So, you must install it so that you can open things in hyprland once it's
installed

### Random programs
```bash
sudo pacman -S kitty #Terminal
sudo pacman -S wl-clipboard cliphist # Wayland compatible clipboard
```


### Hyprland Dep.
```bash
sudo pacman -S hyprland

# Notification display. This or another notification daemon MUST be installed so
# that notifications work properly
sudo pacman -S dunst 
sudo pacman -S polkit-kde-agent # Authentication agent (popup when trying to do root things in GUI)
```


### Nvim Dep.
```bash
sudo pacman -S nvim
sudo pacman -S ripgrep
```

### TMux
```bash
sudo pacman -S tmux # tmux
# Used for sessionizer thing in tmux
sudo pacman -S go && go install github.com/joshmedeski/sesh@latest
```

### cool things
```bash
yay -S rofi-wayland # App launcher
sudo pacman -S waybar # Top bar
sudo pacman -S stow # stow
sudo pacman -S hyprpaper
```

### Fonts
```bash
sudo pacman -S ttf-cascadia-code-nerd
yay -S ttf-space-grotesk
sudo pacman -S ttf-font-awesome
```
