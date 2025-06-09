# dotfiles

> Personal Arch Linux Hyprland Configuration - Inspired by [HyDE](https://github.com/HyDE-Project/HyDE)

A carefully crafted Hyprland configuration for Arch Linux that brings together aesthetic customization with practical functionality. This setup is inspired by the HyDE project, providing a clean, modern, and highly customizable desktop environment.

## 🎨 Overview

This configuration provides a complete Hyprland setup with:
- **Dynamic theming system** with wallpaper-based color schemes
- **Extensive animation library** with multiple preset configurations
- **Modular configuration structure** for easy customization
- **Lock screen themes** with multiple font options
- **Comprehensive keybinding system**
- **Window rules and workspace management**

## 📁 Structure

### Core Configuration Files
- **`hyprland.conf`** - Main Hyprland configuration that sources all other configs
- **`hyde.conf`** - HyDE-specific overrides and environment variables
- **`keybindings.conf`** - Custom keyboard shortcuts and bindings
- **`windowrules.conf`** - Window management rules and behaviors
- **`monitors.conf`** - Display and monitor configuration
- **`userprefs.conf`** - Personal Hyprland preferences
- **`hypridle.conf`** - Idle management configuration
- **`hyprlock.conf`** - Lock screen configuration
- **`hyprsunset.json`** - Sunset/blue light filter settings

### Theming System
```
themes/
├── colors.conf      # Color scheme definitions
├── theme.conf       # Main theme configuration
└── wallbash.conf    # Wallpaper-based color generation
```

### Animation Presets
```
animations/
├── standard.conf    # Standard animations
├── optimized.conf   # Performance-optimized animations
├── minimal-1.conf   # Minimal animation set
├── minimal-2.conf   # Ultra-minimal animations
├── classic.conf     # Classic animation style
├── dynamic.conf     # Dynamic/responsive animations
├── fast.conf        # Fast transition animations
├── moving.conf      # Moving/flowing animations
├── vertical.conf    # Vertical-focused animations
├── high.conf        # High-intensity animations
├── disable.conf     # Disable all animations
├── theme.conf       # Theme-based animations
├── end4.conf        # Custom end4 preset
├── diablo-1.conf    # Diablo-inspired preset 1
├── diablo-2.conf    # Diablo-inspired preset 2
├── ja.conf          # Japanese-style animations
├── me-1.conf        # Personal preset 1
└── me-2.conf        # Personal preset 2
```

### Lock Screen Themes
```
hyprlock/
├── theme.conf          # Default lock screen theme
├── Anurati.conf        # Anurati font theme
├── IBM Plex.conf       # IBM Plex font theme
├── SF Pro.conf         # SF Pro font theme
└── Arfan on Clouds.conf # Cloud-themed layout
```

## 🚀 Features

### Configuration Architecture
- **Three-layer system**: Boilerplate → Overrides → User configurations
- **Modular design**: Each component can be independently customized
- **HyDE integration**: Built on HyDE's proven configuration framework
- **Version control ready**: Proper `.gitignore` for sensitive files

### Theming Capabilities
- **Wallpaper-driven theming**: Colors automatically extracted from wallpapers
- **Dynamic color schemes**: Automatic theme adaptation
- **Multiple animation profiles**: Choose from 19+ different animation presets
- **Custom lock screen layouts**: 5 different lock screen themes

### User Experience
- **Comprehensive keybindings**: Efficient keyboard-driven workflow
- **Smart window management**: Automatic window rules and workspace organization
- **Multi-monitor support**: Flexible monitor configuration
- **Idle management**: Intelligent screen locking and power management

## ⚙️ Installation

1. **Backup existing configuration**:
   ```bash
   mv ~/.config/hypr ~/.config/hypr.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/dotfiles ~/.config/hypr
   ```

3. **Install dependencies**:
   ```bash
   # Core Hyprland components
   sudo pacman -S hyprland hyprlock hypridle
   
   # Additional tools (adjust based on your configuration)
   sudo pacman -S waybar swaync gammastep
   ```

4. **Apply configuration**:
   ```bash
   # Reload Hyprland configuration
   hyprctl reload
   ```

## 🎛️ Customization

### Changing Animation Presets
Edit `animations.conf` to source your preferred animation preset:
```bash
source = ./animations/optimized.conf  # For performance
source = ./animations/minimal-1.conf  # For minimalism
source = ./animations/dynamic.conf    # For responsiveness
```

### Switching Lock Screen Themes
Modify the lock screen theme in `hyprlock.conf`:
```bash
source = ./hyprlock/SF Pro.conf       # Modern San Francisco Pro theme
source = ./hyprlock/IBM Plex.conf     # Professional IBM Plex theme
```

### Theme Configuration
Customize colors and appearance in `themes/`:
- **`colors.conf`**: Define color schemes
- **`theme.conf`**: Configure theme behavior
- **`wallbash.conf`**: Set up wallpaper-based theming

## 🔧 Key Bindings

The configuration includes comprehensive keybindings for:
- **Window management**: Tiling, floating, and workspace operations
- **Application launching**: Quick access to frequently used applications
- **System controls**: Volume, brightness, and power management
- **Screenshot utilities**: Various screenshot and recording options

*(Detailed keybinding reference available in `keybindings.conf`)*

## 🎨 Inspiration

This configuration is inspired by the [HyDE (Hyprdots Desktop Environment)](https://github.com/HyDE-Project/HyDE) project, which provides a comprehensive and beautiful Hyprland setup. HyDE's modular approach to configuration management and theming system serves as the foundation for this personalized setup.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs. If you have improvements or new animation presets, pull requests are welcome!

## 🙏 Acknowledgments

- [HyDE Project](https://github.com/HyDE-Project/HyDE) for the inspiration and configuration framework
- [Hyprland](https://hyprland.org/) for the amazing window manager
- The Arch Linux community
