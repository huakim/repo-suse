#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-base.pl');
#our @pkgs;
j=__import__('apt-base')
pkgs=j.pkgs
main=j.main
env=j.env

if pkgs[0] == 'zypper':
    pkgs.append('yast2-qt-pkg')

if env.check('LIVEINSTALL'):
    pkgs.append('calamares')

qemu=(
    'libvirt',
    'qemu-x86',
    'virt-manager',
    'xterm',
)

if env.check('EXTRAINSTALL'):
    pkgs.extend(qemu)
    pkgs.extend((
        "nekoray", 
        "code", 
        "wine",
        "keepassxc", 
        "gnome-disk-utility"
))

pkgs.extend((
"dbus-1-x11",
"gparted",
#"generic-logos",
"google-roboto-mono-fonts",
"google-opensans-fonts",
#"open-sans-fonts",
#"libopenh264-7",
"pipewire",
"pipewire-pulseaudio",
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
pkgs.extend((
'ffmpeg',
'gstreamer-plugins-good',
'gstreamer-plugins-good-extra',
'gstreamer-plugins-bad',
'gstreamer-plugins-base',
'gstreamer-plugins-ugly',
'gstreamer-plugins-libav',
'gstreamer-plugin-openh264',
'pipewire-aptx',
'libavcodec61',
#'libavcodec60',
'libfdk-aac2',
'dav1d',
))

if __name__ == '__main__':
    main()

