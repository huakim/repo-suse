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

if env.check("EXTRAINSTALL"):
    pkgs.extend((
#"plasma6-mobile",
#"varia",
'kget',
'ktorrent',
"kmenuedit6",
"kdeconnect-kde",
"okular",
"keepassxc",
"neochat",
#"zapzap",
'plasma6-session-x11',
'kwin6-x11',
'falkon',
'remmina-plugin-kwallet'
))



pkgs.extend((
#'plasma-nm-openvpn',
#'accountsservice',
'ark',
'gtk2-metatheme-yaru-mate',
'gtk3-metatheme-yaru-mate',
'gtk4-metatheme-yaru-mate',
'bluedevil6',
'breeze-gtk',
#'calamares',
'colord-kde',
'dolphin',
'gwenview',
'haruna',
'pavucontrol-qt',
#'keepassxc',
'kate',
#'kget',
#'ktorrent',
#'kate-plugins',
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
#'kmenuedit6',
'konsole',
'kwin6',
'pam_kwallet6',
'plasma6-desktop',
#'plasma6-drkonqi',
#'plasma6-milou',
#'plasma6-mobile',
'plasma6-nm',
'plasma6-nm-openvpn',
'plasma6-pa',
#'plasma6-sddm-theme-openSUSE',
'systemsettings6',
'plasma6-session',
'plasma6-systemmonitor',
#'plasma6-theme-stone',
#'plasma6-wayland-protocols',
#'plasma6-workspace-wayland',
'plasma6-workspace',
#'qt5-qdbusviewer',
'sddm-kcm6',
'sddm-qt6',
'plasma6-sddm-theme-openSUSE',
'spectacle',
'systemsettings6',
'upower',
'xdg-desktop-portal-kde'
))

#pkgs.extend((
#'kmail-account-wizard',
#'qt5-qtwebengine-devtools',
#'falkon',
#'kmail'
#))

if __name__ == '__main__':
    main()
