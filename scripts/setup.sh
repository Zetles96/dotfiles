#!/bin/bash
# Post-stow setup script for things GNU Stow can't handle

# GTK4/libadwaita theming (requires absolute symlinks)
GTK4_THEME="/usr/share/themes/catppuccin-mocha-lavender-standard+default/gtk-4.0"

if [ -d "$GTK4_THEME" ]; then
    mkdir -p ~/.config/gtk-4.0
    ln -sf "$GTK4_THEME/assets" ~/.config/gtk-4.0/assets
    ln -sf "$GTK4_THEME/gtk.css" ~/.config/gtk-4.0/gtk.css
    ln -sf "$GTK4_THEME/gtk-dark.css" ~/.config/gtk-4.0/gtk-dark.css
    echo "GTK4/libadwaita theme symlinks created"
else
    echo "Warning: Catppuccin GTK4 theme not found at $GTK4_THEME"
    echo "Install with: paru -S catppuccin-gtk-theme-mocha"
fi

# KDE applications menu symlink (needed for Dolphin "Open With")
if [ ! -f /etc/xdg/menus/applications.menu ] && [ -f /etc/xdg/menus/arch-applications.menu ]; then
    echo "Creating applications.menu symlink (requires sudo)..."
    sudo ln -sf /etc/xdg/menus/arch-applications.menu /etc/xdg/menus/applications.menu
    kbuildsycoca6 --noincremental
    echo "KDE menu symlink created"
fi
