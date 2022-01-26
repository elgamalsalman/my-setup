# mySetup

My main coding setup with instructions and configuration files so that I and anyone else interested can easily make a replica of it on any computer.

- Operating System : [arch](./arch/)
- Display Server : [xorg](./xorg/)
- Display (Login) Manager : [lightdm](./lightdm/)
- Tiling Window Manager : [i3-gaps](./i3gaps/)
- Application Launcher : [rofi]()
- Terminal Emulator : [konsole]()
- Text Editors : [fish-shell]()
  - Competitive Programming : [vim](./cpvim/)
  - Web and App Development : [neovim](./neovim/)

# Arch Linux

Arch Wiki : https://wiki.archlinux.org/title/installation_guide

## Installation Instructions

> If you are using vmware you have to first add this line to the virtual machine `.vmx` file
>
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
pacstrap /mnt base linux linux-firmware base-devel grub efibootmgr networkmanager fish git vim
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
LANGUAGE=en_US
LC_ALL=C
```

then run replacing `HOSTNAME` with the name of your computer, I personally called it `arch`

```
echo HOSTNAME > /etc/hostname
```

```
visudo
```

and remove the `#` infront of the line `# %wheel ALL=(ALL) ALL` then save and quit

```
passwd
```

and choose a root password then

```
useradd -m -G wheel -s /bin/fish USERNAME
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
sudo pacman -Syu git xorg lightdm lightdm-webkit2-greeter i3-gaps rofi nitrogen neofetch lxappearance arc-solid-gtk-theme papirus-icon-theme qt5ct kvantum konsole firefox neovim pcmanfm file-roller mupdf exa ttf-fira-code acpi
sudo systemctl enable lightdm
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
sudo rm -r yay
yay -S lightdm-webkit-theme-aether arc-kde-git picom-ibhagwan-git
mkdir -p ~/.config/picom
mkdir -p ~/.local/share/fonts
```

then

```
sudo pacman -Syu
reboot
```

Then download my [config.fish](./configs/config.fish) and place it in `~/.config/fish/`			<br />
Then download my [i3config](./configs/i3config) rename it to `config` and place it in `~/.config/i3/`			<br />
Then download my [picom.conf](./configs/picom.conf) and place it in `~/.config/picom/`	<br />
Then download my [environment](./configs/environment) and place it in `/etc/`		<br />
Then download the [DarkOneNuanced.colorscheme](./colorschemes/DarkOneNuanced.colorscheme) and place it in `~/.local/share/konsole/`		<br />
Then download the [Fira Code Nerd Font](./fonts/FiraCodeRegularNerdFontComplete.ttf) and place it in `~/.local/share/fonts/`		<br />
Then, if you are into it, download my [neofetch-config.conf](./configs/neofetch-config.conf), rename it to `config.conf` and place it in `~/.config/neofetch/`		<br />

> if you are using vmware make sure you enable accelerated 3d graphics so that picom's glx backend (which is needed for blurring) doesn't freeze all the windows.

> Also install vmware tools for a shared clipboard between the host and the guest.

> if your display doesn't fill the whole screen you can uncomment the `#display-setup-script=` line in your `/etc/lightdm/lightdm.conf` file and add `xrandx -s 1360x768` to the end of it replacing `1360x768` with your screen dimensions

> To set your wallpaper use nitrogen which you have already installed if you followed the setup instructions. You can find some cool wallpapers in the [wallpapers](./wallpapers) folder of this repository.

> To change the system theme and icons for both gtk and qt applications do the following. For gtk open lxappearance and choose from the installed themes, I personally use arc dark with papirus icons. For qt open qt5ct and change the theme to kvantum and open the kvantum manager, click change/delete theme and choose the theme you want.

> To change konsole theme hit `ctrl-shift-,` open your profile and change the theme to Dark One Nuanced. Check the show all fonts checkbox and change the font to Fira Code Nerd for cool ligatures and glyphs. If a menu bar is visible at the top you can remove it by clicking on the settings tab and uncheck show menubar and all toolbars shown. 

> To change konsole copy and paste keybindings hit `ctrl-alt-,`, and search for the copy and the past keybindings and change them to `ctrl-c` and `ctrl-v` respectively.

> To change rofi theme run `rofi-theme-selector` in the terminal, I use arc dark here too.

> There is an arc theme for firefox if you are into that, click on the 3 bar menu > more tools > customise toolbar.

## Github Connection Instructions

First generate a new access token from github and copy it, then run this command on the terminal

```
git config --global user.email "EMAIL"
git config --global user.name "NAME"
git config --global credential.helper store
```

replacing `EMAIL` with your github email address and `NAME` with your name or username.

the first github operation you do will require your email and password, paste your access token in place of the password, git will then store your credentials and will automatically pass them the next time you run a github command.
