#/bin/bash

timedatectl set-timezone Asia/Kolkata
loadkeys /usr/share/kbd/keymaps/i386/qwerty/us.map.gz


lsblk
echo "
mkfs.ext4 /dev/sda5
mkswap /dev/sda6
"
mount /dev/sda5 /mnt
swapon /dev/sda6
pacman -Sy
pacman -Sy pacman-contrib archlinux-keyring

rankmirrors -n 10 /tmp/mirrorlist > /etc/pacman.d/mirrorlist

pacstarp -i /mnt base linux linux-firmware wget curl
echo -e "Install further these pkg: linux-headers intel-ucode nano sudo vim git neofetch networkmanager dhcpcd pulseaudio bluez wpa_supplicant \n May install: base-devel linux-lts"

genfstab -U /mnt >> /mnt/etc/fstab
