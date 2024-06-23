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
#'plasma-nm-openvpn',
#'accountsservice',
'ark',
'bluedevil6',
'breeze-gtk',
#'calamares',
'colord-kde',
'dolphin',
'gtk2-metatheme-breeze',
'gtk3-metatheme-breeze',
'gtk4-metatheme-breeze',
#'gnome-disk-utility',
'gwenview',
'haruna',
'pavucontrol-qt',
'keepassxc',
'kate',
'kget',
'ktorrent',
#'kate-plugins',
'kdeconnect-kde',
#'kde-inotify-survey',
'kde-gtk-config6',
'kde-inotify-survey',
#'kde-settings-plasma',
#'kde-settings-pulseaudio',
#'kdialog',
#'kf5-kunitconversion',
#'kio-admin',
'kio-extras',
'kio-fuse',
'kmenuedit6',
'konsole',
#'kscreen',
#'ktorrent',
#'kwayland-integration',
'kwin6',
'kwin6-x11',
#'kwin-x11',
#'materia-gtk-theme',
#'materia-kde',
#'lightdm',
#'lightdm-settings',
'plasma6-desktop',
#'plasma6-drkonqi',
#'plasma6-milou',
'plasma6-mobile',
'plasma6-nm',
'plasma6-pa',
'plasma6-sddm-theme-openSUSE',
'plasma6-session-x11',
'plasma6-settings',
'plasma6-session',
'plasma6-systemmonitor',
#'plasma6-wayland-protocols',
#'plasma6-workspace-wayland',
'plasma6-workspace',
#'qt5-qdbusviewer',
#'slick-greeter',
'sddm-qt6',
#'sddm-breeze',
'sddm-kcm6',
'spectacle',
'systemsettings6',
'upower'
#'xdg-desktop-portal-kde'
))

pkgs.extend((
#'kmail-account-wizard',
#'qt5-qtwebengine-devtools',
'falkon',
'kmail'
))

if __name__ == '__main__':
    main()
