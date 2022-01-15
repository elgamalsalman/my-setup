# mySetup
My main coding setup with instructions and configuration files so that I and anyone else interested can easily make a replica of it on any computer.

- Operating System : [arch](./arch/)
- Display Server : [xorg](./xorg/)
- Display (Login) Manager : [lightdm](./lightdm/)
- Tiling Window Manager : [xmonad](./xmonad/)
- Application Launcher : [rofi]()
- Terminal Emulator : [konsole]()
- Text Editors : [fish-shell]()
  - Competitive Programming : [vim](./cpvim/)
  - Web and App Development : [neovim](./neovim/)

# Arch Linux
Arch Wiki : https://wiki.archlinux.org/title/installation_guide

## Installation Instructions
> If you are using vmware you have to first add this line to the virtual machine .VMX file
> ```
> firmware = "efi"
> ```
First make sure the internet connection is working by `ping google.com` then proceed to
```
timedatectl set-ntp true
fdisk /dev/sda
```
create a GPT partition table with 3 partitions:
  - sda1 : UEFI (size: +550M, type: EFI System)
  - sda2 : swap (size: 0 to +8G, type: Linux swap)
  - sda3 : filesystem (size: rest, type: Linux filesystem)

then write the changes to the disk
```
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
pacstrap /mnt base linux linux-firmware base-devel grub efibootmgr networkmanager git vim 
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime
hwclock --systohc
vim /etc/locale.gen
```
replacing `REGION` and `CITY` with your location. Use `ls /usr/share/zoneinfo` to get the list of regions and `ls /usr/share/zoneinfo/REGION` for the list of cities in the specified region.

now remove the `#` infront of the following line `#en_US.UTF-8 UTF-8` and then save and quit
```
vim /etc/locale.conf
```
and write the following in the file and save and quit
```
LANG=en_US.UTF-8
```
then
```
vim /etc/hostname
```
and write the hostname you prefer (e.g. `arch`) then save and quit
```
visudo
```
and remove the `#` infront of the line `# %wheel ALL=(ALL) ALL` then save and quit
```
passwd
```
and choose a root password then
```
useradd -m -G wheel -s /bin/bash USERNAME
passwd USERNAME
```
replacing `USERNAME` with the username you prefer and choosing a password
```
systemctl enable NetworkManager
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -a
reboot
```

## Setup Instructions
This assumes that you have followed the Installation Instructions and have arch up and running and you have signed into your user account.
```
sudo pacman -S git xorg lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan xmonad xmonad-contrib xmobar rofi picom nitrogen neofetch lxappeaerance qt5ct konsole firefox neovim pcmanfm mupdf
sudo systemctl enable lightdm
mkdir .xmonad
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
sudo rm -r yay
sudo yay -S lightdm-webkit-theme-aether
```
set up lightdm litarvan theme using
```
sudo vim /etc/lightdm/lightdm.conf
```
and set `greeter-session=lightdm-webkit2-greeter` then 
```
sudo vim /etc/lightdm/lightdm-webkit2-greeter.conf
```
and set `webkit\_theme` to `litarvan`

Then download my [.bashrc](./.bashrc) and place it in `/`			<br />
Then download my [.xprofile](./.xprofile) and place it in `/`			<br />
Then download my [xmonad.hs](./xmonad.hs) and place it in `/.xmonad`		<br />
Then download my [picom.conf](./picom.conf) and place it in `/.config/picom`	<br />

and finally
```
sudo pacman -Syu
reboot
```

> if your display doesn't fill the whole screen you can uncomment the `#display-setup-script=` line in your `/etc/lightdm/lightdm.conf` file and add `xrandx -s 1360x768` to the end of it replacing `1360x768` with your screen dimensions

## Github Connection Instructions
