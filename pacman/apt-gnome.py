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

pkgs.extend((
"NetworkManager-openvpn-gnome",
#"adwaita-gtk2-theme",
#"adwaita-qt5",
#"adwaita-qt6",
"alacarte",
"celluloid",
"dconf-editor",
"eog",
"evince",
"file-roller",
"nautilus-file-roller",
"geany",
#"geany-themes",
"gcr3",
"gdm",
"gjs",
"gnome-color-manager",
"gnome-control-center",
"gnome-disk-utility",
"extension-manager",
"gnome-keyring",
"gnome-menus",
"gnome-power-manager",
"gnome-remote-desktop",
"gnome-session",
"gnome-session-wayland",
"gnome-shell-extension-appindicator",
#"gnome-shell-extension-dash-to-dock",
#"gnome-shell-extension-gsconnect",
"gnome-system-monitor",
"gnome-terminal",
"nautilus-extension-terminal",
"gnome-themes-extras",
"gnome-tweaks",
"gvfs",
"gvfs-fuse",
"gvfs-backends",
"libnma",
"nautilus",
#"nautilus-gsconnect",
"pavucontrol",
"polkit-gnome",
#"qgnomeplatform-qt5",
#"qgnomeplatform-qt6",
#"redshift",
#"remmina",
#"remmina-plugins-rdp",
#"remmina-plugins-secret",
#"remmina-plugins-vnc",
'transmission-gtk',
#"valent",
'uget',
"xdg-desktop-portal-gtk"
))

for i in ('good', 'bad', 'base', 'ugly' ):
    pkgs.append("gstreamer-plugins-"+i)
pkgs.append('gstreamer-plugin-openh264')

pkgs.extend((
'geary',
'epiphany',
#'evolution',
'seahorse'
))

#for i in ('dm', 'mpath', 'btrfs', 'lvm', 'nvdimm'):
#    pkgs.append('libblockdev-'+i)
#pkgs.append('anaconda-live')

if __name__ == '__main__':
    main()
