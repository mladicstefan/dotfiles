#!/bin/bash

#!      ░▒▒▒░░░▓▓           ___________
#!    ░░▒▒▒░░░░░▓▓        //___________/
#!   ░░▒▒▒░░░░░▓▓     _   _ _    _ _____
#!   ░░▒▒░░░░░▓▓▓▓▓▓ | | | | |  | |  __/
#!    ░▒▒░░░░▓▓   ▓▓ | |_| | |_/ /| |___
#!     ░▒▒░░▓▓   ▓▓   \__  |____/ |____/
#!       ░▒▓▓   ▓▓  //____/


set -e 

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
HYPR_CONFIG_DIR="$CONFIG_DIR/hypr"
BACKUP_DIR="$CONFIG_DIR/hypr.backup.$(date +%Y%m%d_%H%M%S)"

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}======================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}======================================${NC}"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_packages() {
    local packages=("$@")
    print_status "Installing packages: ${packages[*]}"
    
    sudo pacman -Sy
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
}

install_aur_packages() {
    local packages=("$@")
    if command_exists yay; then
        print_status "Installing AUR packages: ${packages[*]}"
        yay -S --needed --noconfirm "${packages[@]}" || print_warning "Some AUR packages may have failed to install"
    else
        print_warning "yay not found. Please install these AUR packages manually: ${packages[*]}"
    fi
}

backup_existing_config() {
    if [ -d "$HYPR_CONFIG_DIR" ]; then
        print_status "Backing up existing Hyprland configuration to $BACKUP_DIR"
        cp -r "$HYPR_CONFIG_DIR" "$BACKUP_DIR"
        print_success "Backup created at $BACKUP_DIR"
    fi
}

copy_dotfiles() {
    print_status "Creating ~/.config/hypr directory"
    mkdir -p "$HYPR_CONFIG_DIR"
    
    print_status "Copying dotfiles to $HYPR_CONFIG_DIR"
    
    cp -r "$SCRIPT_DIR"/* "$HYPR_CONFIG_DIR"/ 2>/dev/null || true
    
    rm -f "$HYPR_CONFIG_DIR/install.sh"
    
    chmod -R 644 "$HYPR_CONFIG_DIR"
    find "$HYPR_CONFIG_DIR" -type d -exec chmod 755 {} \;
    
    print_success "Dotfiles copied successfully"
}

enable_services() {
    print_status "Enabling and starting systemd services"

    if command_exists blueman-applet; then
        sudo systemctl enable bluetooth.service || true
        sudo systemctl start bluetooth.service || true
    fi
    
    if command_exists nm-applet; then
        sudo systemctl enable NetworkManager.service || true
        sudo systemctl start NetworkManager.service || true
    fi
}

main() {
    print_header "HyDE-Inspired Hyprland Dotfiles Installation"
    
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is designed for Arch Linux. Exiting."
        exit 1
    fi
    
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root. Exiting."
        exit 1
    fi
    
    print_header "Step 1: Installing Core Packages"
    
    core_packages=(
        "hyprland"
        "hyprlock"
        "hypridle"
        "xdg-desktop-portal-hyprland"
        "wayland"
        "wayland-protocols"
        "wlroots"
    )
    install_packages "${core_packages[@]}"
    
    print_header "Step 2: Installing Essential Wayland Tools"
    
    wayland_tools=(
        "waybar"                    # Status bar
        "swaync"                    # Notification daemon
        "swww"                      # Wallpaper daemon
        "rofi-wayland"              # Application launcher
        "wl-clipboard"              # Clipboard utilities
        "cliphist"                  # Clipboard history
        "grim"                      # Screenshot tool
        "slurp"                     # Screen area selection
        "swappy"                    # Screenshot annotation
        "wf-recorder"               # Screen recording
    )
    install_packages "${wayland_tools[@]}"
    
    print_header "Step 3: Installing System Integration Tools"
    
    system_tools=(
        "polkit"                    # Authentication agent
        "polkit-kde-agent"          # KDE polkit agent
        "xdg-desktop-portal"        # Desktop portals
        "xdg-desktop-portal-gtk"    # GTK portal
        "pipewire"                  # Audio server
        "pipewire-pulse"            # PulseAudio compatibility
        "wireplumber"               # Session manager
        "gammastep"                 # Blue light filter
        "brightnessctl"             # Brightness control
        "pamixer"                   # Audio control
        "pavucontrol"               # Audio mixer GUI
    )
    install_packages "${system_tools[@]}"
    
    print_header "Step 4: Installing Network and Bluetooth Tools"
    
    network_tools=(
        "networkmanager"            # Network management
        "nm-connection-editor"      # Network manager GUI
        "network-manager-applet"    # Network applet
        "bluez"                     # Bluetooth protocol stack
        "bluez-utils"               # Bluetooth utilities
        "blueman"                   # Bluetooth manager
    )
    install_packages "${network_tools[@]}"
    
    print_header "Step 5: Installing File Management and Utilities"
    
    utilities=(
        "dolphin"                   # File manager
        "ark"                       # Archive manager
        "udiskie"                   # Removable media manager
        "udisks2"                   # Disk management
        "tumbler"                   # Thumbnail generator
        "ffmpegthumbs"              # Video thumbnails
        "imagemagick"               # Image manipulation
        "jq"                        # JSON processor (for scripts)
    )
    install_packages "${utilities[@]}"
    
    print_header "Step 6: Installing Appearance and Theming Tools"
    
    theming_tools=(
        "qt6ct"                     # Qt6 configuration
        "qt5ct"                     # Qt5 configuration
        "kvantum"                   # Qt theme engine
        "nwg-look"                  # GTK theme switcher
        "gtk-engine-murrine"        # GTK theme engine
        "gtk-engines"               # GTK theme engines
        "ttf-nerd-fonts-symbols"    # Nerd fonts symbols
        "ttf-font-awesome"          # Font Awesome icons
    )
    install_packages "${theming_tools[@]}"
    
    print_header "Step 7: Installing Optional Terminal and Development Tools"

    optional_tools=(
        "kitty"                     # Terminal emulator
        "fish"                      # Fish shell
        "starship"                  # Shell prompt
        "eza"                       # Modern ls replacement
        "bat"                       # Modern cat replacement
        "ripgrep"                   # Fast grep replacement
        "fd"                        # Fast find replacement
        "btop"                      # Modern htop replacement
        "neofetch"                  # System info
    )
    
    read -p "Install optional terminal and development tools? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_packages "${optional_tools[@]}"
    fi
    
    print_header "Step 8: Installing AUR Packages (if yay is available)"
    
    aur_packages=(
        "hyprpicker"                # Color picker
        "wlogout"                   # Logout menu
        "swaylock-effects"          # Enhanced lock screen
        "waybar-hyprland"           # Waybar with Hyprland support
    )
    install_aur_packages "${aur_packages[@]}"
    
    print_header "Step 9: Backing Up Existing Configuration"
    backup_existing_config
    
    print_header "Step 10: Installing Dotfiles"
    copy_dotfiles
    
    print_header "Step 11: Enabling System Services"
    enable_services
    
    print_header "Installation Complete!"
    
    print_success "HyDE-inspired Hyprland configuration has been installed successfully!"
    echo
    print_status "Next steps:"
    echo "  1. Log out of your current session"
    echo "  2. Select 'Hyprland' from your display manager"
    echo "  3. Log in to start using your new configuration"
    echo
    print_status "Configuration location: $HYPR_CONFIG_DIR"
    if [ -d "$BACKUP_DIR" ]; then
        print_status "Backup location: $BACKUP_DIR"
    fi
    echo
    print_status "To customize your setup:"
    echo "  • Edit animation presets in: $HYPR_CONFIG_DIR/animations/"
    echo "  • Modify themes in: $HYPR_CONFIG_DIR/themes/"
    echo "  • Adjust keybindings in: $HYPR_CONFIG_DIR/keybindings.conf"
    echo "  • Configure monitors in: $HYPR_CONFIG_DIR/monitors.conf"
    echo
    print_warning "If you encounter any issues, you can restore your backup:"
    if [ -d "$BACKUP_DIR" ]; then
        echo "  rm -rf $HYPR_CONFIG_DIR && mv $BACKUP_DIR $HYPR_CONFIG_DIR"
    fi
    
    echo
    print_success "Enjoy your new HyDE-inspired Hyprland setup! 🎉"
}

main "$@"