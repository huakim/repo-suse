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
#"gnome-shell-extension-desktop-icons", #gtk4-ding",
#"gnome-shell-extension-valent",
#"nautilus-extension-terminal",
#"nautilus-file-roller",
'transmission-gtk',
#'nemo-extension-gsconnect',
#'varia',
#'valent',
#'ungoogled-chromium',
#'epiphany',
#'evolution',
"fractal",
"secrets",
"uget",
'seahorse'
#'waterfox-wayland'
#'Tangram'
)

if env.check("GNOME_ANIMATIONS"):
    pkgs.extend(
    (
    "gnome-shell-extension-dash2dock-lite",
    "gnome-shell-extension-system-monitor",
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
#"adwaita-qt5",
#"adwaita-qt6",
"celluloid",
"eog",
#"evolution",
"extension-manager",
"engrampa",
"gnome-shell-extension-gsconnect",
#"nautilus-file-roller",
"geany",
"gtk2-metatheme-adwaita",
"gtk3-metatheme-adwaita",
#"geany-themes",
"gcr3",
"gdm",
"gjs",
"gnome-color-manager",
"gnome-control-center",
"gnome-keyring",
"gnome-menus",
"gnome-shell-extension-power-off-options",
#"gnome-online-accounts",
"gnome-power-manager",
"gnome-session",
"gnome-session-wayland",
"gnome-shell-extension-appindicator",
"gnome-shell-extension-unite",
"gnome-shell-extension-desktop-icons", #gtk4-ding",
#"gnome-shell-extension-gsconnect",
"gnome-system-monitor",
"nautilus-extension-terminal",
"gnome-themes-extras",
"gnome-tweaks",
"gvfs",
"gvfs-fuse",
"gvfs-backends",
#"keepassxc",
"libnma",
"libgnomesu",
"nautilus",
#"nautilus-gsconnect",
"pavucontrol",
"polkit-gnome",
#"QGnomePlatform-qt5",
#"QGnomePlatform-qt6",
#"redshift",
#"remmina",
#"remmina-plugins-rdp",
#"remmina-plugins-secret",
#"remmina-plugins-vnc",
#'thunar',
#'thunar-plugin-archive',
#'thunar-volman',
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
