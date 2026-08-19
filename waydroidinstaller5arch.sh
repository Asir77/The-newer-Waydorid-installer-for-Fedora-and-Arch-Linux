#!/bin/bash

# Check gum is installed before we try to use it
if ! command -v gum &> /dev/null; then
  echo "gum is required but not installed. Install it first: https://github.com/charmbracelet/gum"
  exit 1
fi
if ! command -v figlet &> /dev/null; then
  echo "figlet is required but not installed. Install it first: sudo pacman -S figlet"
  exit 1
fi

# Request sudo password once at the start
sudo -v || exit 1
echo WELCOME TO THE WAYDROID INSTALLER 

if gum confirm "Update system? (this is highly recommended)"; then
  gum spin --title "Updating system..." -- sudo pacman -Syu || exit 1
  echo "Updated system"
else
  echo "Cancelled — some things may break. Re-run the script later if you're not sure it'll work."
fi

if gum confirm "Install waydroid?"; then
  gum spin --title "Installing waydroid..." -- sudo pacman -S waydroid || exit 1
  echo "Install successful. If you see any errors, take matters into your own hands — some Google searches should help you."
else
  echo "Waydroid install cancelled. What are you doing bro, you're supposed to install it :)"
fi

if gum confirm "Launch Waydroid?"; then
  gum spin --title "Initializing Waydroid..." -- sudo waydroid init || exit 1
  waydroid show-full-ui &
  echo "Done!"
else
  echo "..."
fi

if gum confirm "See after-installation tips?"; then
  echo "After installing everything and opening Waydroid (you can open it from your application menu), I'd recommend going through and picking what Android image to install :D thanks for using this script...!"
else
  echo "..."
fi

fastfetch
echo "thank you really!"
exit 0
