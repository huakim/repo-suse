#!/bin/sh

dir="$(realpath $(dirname $0))/"

export HOME="/etc/skel"

lT='ln -sfTv'
sk(){
    mkdir "/etc/skel/${1}"
}

uP(){
    if [ -e "$3" ]; then
        if [ ! -e "$1" ]; then
            update-alternatives --install "${@}"
        fi
    fi
}

if [[ "${INSTALLATION_VARIANT}" == labwc ]]; then
  mkdir -pv /etc/environment.d
  cat << EOF > /etc/environment.d/theme.conf
QT_SCALE_FACTOR=0.9
QT_FONT_DPI=96
QT_QPA_PLATFORMTHEME=qt6ct
GTK_THEME=Yaru-MATE-dark
EOF
fi

#localectl set-locale en_US.UTF-8
#localectl set-keymap us

ds(){
    local fp="/etc/xdg/autostart/$1.desktop"
    local ft="/etc/xdg/autostart-disabled/$1.desktop"
    mkdir -pv /etc/xdg/autostart-disabled
    if [ -f "$fp" ]; then
        rm -v "$ft"
        mv -v "$fp" "$ft"
    fi
}

mv /usr/lib/modprobe.d/50-blacklist-rndis.conf{,.disabled}
#sed -i "s/^SELINUX=.*/SELINUX=enforcing/" /etc/selinux/config
#systemctl enable relabel-selinux
systemctl enable NetworkManager
systemctl enable sddm
systemctl disable NetworkManager-wait-online
#systemctl enable NetworkManager

ds xfsettingsd
ds org.gnome.Evolution-alarm-notify
#ds ca.andyholmes.Valent-autostart
ds geoclue-demo-agent
#ds org.kde.kdeconnect.daemon
ds org.kde.kalendarac
ds kaccess

kver="$(ls /lib/modules)"

$lT ../usr/share/zoneinfo/Etc/GMT-3 /etc/localtime
$lT "vmlinuz-${kver}" /boot/vmlinuz
$lT "initrd-${kver}" /boot/initrd

uP /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/gnome-terminal 25
uP /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/xfce4-terminal 25
uP /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/konsole 25
uP /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/terminator 25
uP /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/qterminal 25
uP /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/lxterminal 25
uP /usr/bin/sensible-browser sensible-browser /usr/bin/falkon 25
uP /usr/bin/sensible-browser sensible-browser /usr/bin/epiphany 25
uP /usr/bin/kvm kvm /usr/bin/qemu-kvm 25
uP /usr/bin/gnome-terminal gnome-terminal /usr/bin/konsole 25
uP /usr/bin/gnome-terminal gnome-terminal /usr/bin/xfce4-terminal 25
uP /usr/bin/gnome-terminal gnome-terminal /usr/bin/terminator 25
uP /usr/bin/gnome-emulator gnome-terminal /usr/bin/qterminal 25
uP /usr/bin/gnome-emulator gnome-terminal /usr/bin/lxterminal 25
uP /usr/bin/vi vi /usr/bin/nano 25
uP /usr/bin/python python /usr/bin/python3 25
uP /usr/bin/dnf dnf /usr/bin/dnf5 25
uP /usr/bin/dnf dnf /usr/bin/zypper 25
uP /usr/bin/waybar waybar /usr/bin/sfwbar 25

sk Downloads
sk Desktop
sk Documents
sk Music
sk Pictures
sk Videos
sk Templates
sk Public
sk Screenshots

. "$dir/gnome.sh"
