# mySetup
My main coding setup, including OS, text editor and configuration files for both.

**Setups**
- Operating System : [Arch Linux](./arch/)
- Display server : [Xorg](./xorg/)
- Window Manager : [XMonad](./xmonad/)
- Text Editors:
  - Competitive Programming : [Vim](./cpvim/)
  - Web and App Development : [Neovim](./neovim/)

# Arch Linux
Arch Wiki : https://wiki.archlinux.org/title/installation_guide

## Installation Instructions
First make sure the internet connection is working by `ping google.com` then proceed to
```
# timedatectl set-ntp true
# fdisk /dev/sda
```
create a GPT partition table with 3 partitions:
  - sda1 : UEFI (size: +550M, type: EFI System)
  - sda2 : swap (size: 0 to +8G, type: Linux swap)
  - sda3 : filesystem (size: rest, type: Linux filesystem)

then write the changes to the disk
```
# mkfs.fat -F 32 /dev/sda1
# mkswap /dev/sda2
# swapon /dev/sda2
# mkfs.ext4 /dev/sda3

# mount /dev/sda3 /mnt
# mkdir -p /mnt/boot/efi
# mount /dev/sda1 /mnt/boot/efi
# pacstrap /mnt base linux linux-firmware base-devel grub efibootmgr networkmanager git vim 
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt
# ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime
# hwclock --systohc
# vim /etc/locale.gen
```
replacing `REGION` and `CITY` with your location. Use `ls /usr/share/zoneinfo` to get the list of regions and `ls /usr/share/zoneinfo/REGION` for the list of cities in the specified region.

now remove the `#` infront of the following line `#en_US.UTF-8 UTF-8` and then save and quit
```
# vim /etc/locale.conf
```
and write the following in the file and save and quit
```
LANG=en_US.UTF-8
```
then
```
# vim /etc/hostname
```
and write the hostname you prefer (e.g. `arch`) then save and quit
```
# visudo
```
and remove the `#` infront of the line `# %wheel ALL=(ALL) ALL` then save and quit
```
# passwd
```
and choose a root password then
```
# useradd -m -G wheel -s /bin/bash USERNAME
# passwd USERNAME
```
replacing `USERNAME` with the username you prefer and choosing a password
```
# systemctl enable NetworkManager
# grub-install /dev/sda
```
