#!/bin/python3

j=__import__('apt-base')
pkgs=j.pkgs
main=j.main
env=j.env

if pkgs[0] == 'zypper':
    pkgs.append('yast2-qt-pkg')

if env.check("FLATSERVERINSTALL"):
    pkgs.extend(("ungoogled-chromium", "fractal", "weston"))

if env.check('LIVEINSTALL'):
    pkgs.append('calamares')

qemu=(
    'libvirt',
    'qemu',
    'virt-manager',
    'xterm',
    'qemu-ui-gtk',
    'qemu-hw-display-virtio-gpu',
    'qemu-hw-display-virtio-vga',
    'qemu-hw-display-virtio-gpu-pci',
    'qemu-vhost-user-gpu',
    'qemu-spice'
)

if env.check('EXTRAINSTALL'):
    pkgs.extend(qemu)
    pkgs.extend((
        "nekobox", 
        "codium", 
        "remmina",
        "remmina-plugin-vnc",
        "remmina-plugin-rdp",
#        "winetricks",
#	'wine-stable',
        "plymouth-dracut",
#        "anbox-modules",
#        "anbox-kmp",
#        "anbox-ueficert",
#        "waydroid-image",
# 	"waydroid",       
#        "chromium",
        "webapp-manager",
        "gnome-disk-utility"
))

pkgs.extend((
"dbus-1",
"gparted",
#"generic-logos",
"google-roboto-mono-fonts",
"google-opensans-fonts",
#"open-sans-fonts",
#"libopenh264-7",
"pipewire",
"pipewire-pulseaudio",
'ubuntu-fonts',
#"pipewire-media-session",
#"plymouth",
"pulseaudio-utils",
#"keepassxc",
#"secrets",
#"uget",
"xdg-dbus-proxy",
"xdg-utils",
"xf86-input-evdev",
"xf86-input-joystick",
#"xf86-input-keyboard",
"xf86-input-libinput",
"xf86-input-mouse",
"xf86-input-synaptics",
"xf86-input-vmmouse",
"xf86-input-void",
"xf86-input-wacom",
"xf86-video-amdgpu",
"xf86-video-ark",
"xf86-video-ati",
"xf86-video-intel",
"xf86-video-nouveau",
"xhost",
#"xterm",
"xinit",
"xmessage",
#"xorg-x11-fonts",
"xorg-x11-server",
"xorg-x11-server-extra"
#"xhost",
#"xinit",
#"xmessage",
#"xorg-x11-drv-intel",
#"xorg-x11-drv-nouveau",
#"xorg-x11-server-Xephyr",
#"xorg-x11-server-Xorg",
))

#codecs
codecs=(
'ffmpeg',
*[
f'gstreamer-plugins-{a}{b}' for a, b in zip([
'good',
'good-extra',
'bad',
'base',
'ugly',
'libav'
], ['', '-32bit'])
],
#'pipewire-aptx',
#'libavcodec61',
#'libavcodec60',
'libfdk-aac2',
'dav1d',
)

pkgs.extend(codecs)

if __name__ == '__main__':
    main()

