#This Script will run in arch-chroot env

echo "arch-chroot /mnt"

passwd

useradd -m akash

passwd akash

usermod -aG wheel,storage,power akash

EDITOR=nano visudo
echo -e "uncomment \n # %wheel ALL=(ALL) ALL"

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen
echo LANG=en_US.UTF-8 >/etc/locale.conf
export LANG=en_US.UTF-8

echo arch > /etc/hostname

cat >> /etc/hosts <<- EOM
127.0.0.1    localhost
::1          localhost
127.0.0.1    arch.localdomain    localhost
EOM

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc


####### GRUB
mkdir /boot/efi

mount /dev/sda1 /boot/efi

pacman -Sy grub efibootmgr dosfstools mtools


echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
pacman -Sy os-prober

grub-install --target=x86_64-efi --bootloader-id=Arch --recheck

grub-mkconfig -o /boot/grub/grub.cfg

ls /boot/efi/EFI/

systemctl enable dhcpcd.service
systemctl enable NetworkManager.service

