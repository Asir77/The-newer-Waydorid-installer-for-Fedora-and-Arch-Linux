#!/bin/bash
# Check gum is installed before we try to use it
if ! command -v gum &> /dev/null; then
  echo "gum is required but not installed. Install it first by visiting this website: https://github.com/charmbracelet/gum"
  echo "------------------------------------------------------------------------------------------------------------------"
  exit 1
fi
if ! command -v figlet &> /dev/null; then
  echo "figlet is required but not installed. Install it first using this command: sudo dnf install figlet"
  echo "--------------------------------------------------------------------------------------------------"
  exit 1
fi

echo "WELCOME TO THE WAYDROID INSTALLER  "

# Request sudo password once at the start
sudo -v || exit 1

if gum confirm "Update system? (this is highly recommended)"; then
gum spin --title "Updating system..." -- sudo dnf -y --setopt=gpgcheck=1 update  echo "Updated system!"
  echo "--------------"
else
  echo "------------------------------------------------------------------------------------------------------------------------- |"
  echo "Cancelled some things may break you should do that by re-running the script if you are not sure if the script will work...|"
  echo "--------------------------------------------------------------------------------------------------------------------------|"
fi

if gum confirm "Add Waydroid COPR repo?"; then
  gum spin --title "Adding COPR repo..." -- sudo dnf copr enable -y aleasto/waydroid || exit 1
  echo "-----------------------------------------------------------------|"
  echo "Successful! If there are errors a google search should help you :|"
  echo "-----------------------------------------------------------------|"
else
  echo "----------------------------------------------------------------------------------------------------|"
  echo "this is highly recommended if you dont have the repo then waydroid install may fail...so be cautious|"
  echo "----------------------------------------------------------------------------------------------------|"
fi

if gum confirm "install waydroid"; then
  gum spin --title "Installing waydroid..." -- sudo dnf install -y waydroid || exit 1
  echo "-------------------------------------------------------------------------------------------------------------------|"
  echo "install successful if you see any errors then take matters into your own hands some google searches should help you|"
  echo "-------------------------------------------------------------------------------------------------------------------|"
else
  echo "----------------------------------------------------------------------------- |"
  echo "Waydroid install cancled what are you doing bro your supposed to install it :)|"
  echo "------------------------------------------------------------------------------|"
fi

if gum confirm "Enable the Waydroid service using Systemctl?"; then
  gum spin --title "OK! Working on it now!" -- bash -c "sudo systemctl enable --now waydroid-container" || exit 1
  echo "-----|"
  echo "Done!|"
  echo "-----|"
fi

if gum confirm "See after-installation tips?"; then
  echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
  echo "After installing everything and opening Waydroid (you can open it from your application menu), I'd recommend going through and picking what Android image to install :D thanks for using this script....!"
  echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
else
  echo "..."
fi


if command -v fastfetch &> /dev/null; then
  fastfetch
fi

echo "Thank you really!"
figlet -f slant "WAYDROID TIME!"
exit 0

