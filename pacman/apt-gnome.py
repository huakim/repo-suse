#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-gui.pl');
#our @pkgs;

#push @pkgs, qw(
#tangram
#valent
#gnomesu
#);
j=__import__('apt-gui')
pkgs=j.pkgs
main=j.main
env=j.env

qemu=(
"alacarte",
"atril",
"dconf-editor",
"gnome-disk-utility",
"gnome-remote-desktop",
'transmission-gtk',
"fractal",
"secrets",
"uget",
'seahorse'
)

if env.check("GNOME_ANIMATIONS"):
    pkgs.extend(
    (
    "gnome-shell-extension-dash2dock-lite",
    "gnome-shell-extension-desktop-cube",
    "gnome-shell-extension-compiz-windows-effect"
    )
)
else: 
    pkgs.append("gnome-shell-extension-dash-to-dock")


if env.check('EXTRAINSTALL'):
    pkgs.extend(qemu)


pkgs.extend((
"NetworkManager-openvpn-gnome",
"celluloid",
"eog",
"extension-manager",
"engrampa",
"gnome-shell-extension-gsconnect",
"geany",
"gtk2-metatheme-adwaita",
"gtk3-metatheme-adwaita",
"gcr3",
"gdm",
"gjs",
"gnome-color-manager",
"gnome-control-center",
"gnome-keyring",
"gnome-menus",
"gnome-shell-extension-power-off-options",
"gnome-power-manager",
"gnome-session",
"gnome-session-wayland",
"gnome-shell-extension-appindicator",
"gnome-shell-extension-system-monitor",
"gnome-shell-extension-unite",
"gnome-shell-extension-desktop-icons",
"gnome-system-monitor",
"nautilus-extension-terminal",
"gnome-themes-extras",
"gnome-tweaks",
"gvfs",
"gvfs-fuse",
"gvfs-backends",
"libnma",
"libgnomesu",
"nemo",
"pavucontrol",
"polkit-gnome",
"qt6-platformtheme-gtk3",
"libqt5-qtbase-platformtheme-gtk3",
"gnome-keyring-pam",
"gnome-terminal",
"xdg-desktop-portal-gtk"
))


#ffmpeg gstreamer-plugin{s-{good{,-extra},bad,base,ugly,libav},-openh264} pipewire-aptx libavcodec-full libfdk-aac2 dav1d 
#for i in ('good', 'bad', 'base', 'ugly' ):
#    pkgs.append("gstreamer-plugins-"+i)
#pkgs.append('gstreamer-plugin-openh264')

pkgs.extend((
#'epiphany',
#'evolution',
#'seahorse',
#'Tangram'
))

#for i in ('dm', 'mpath', 'btrfs', 'lvm', 'nvdimm'):
#    pkgs.append('libblockdev-'+i)
#pkgs.append('anaconda-live')

if __name__ == '__main__':
    main()
