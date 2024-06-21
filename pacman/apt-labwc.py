#!/usr/bin/python3
j=__import__('apt-gui')
pkgs=j.pkgs
main=j.main

pkgs.extend((
"adwaita-xfce-icon-theme",
"NetworkManager-gnome",
"dbus-1-daemon",
"epiphany",
"evolution",
"gnome-themes-extras",
"labwc",
"sddm-qt6",
"sfwbar",
"thunar",
"thunar-archive-plugin",
"thunar-volman",
"xfce4-desktop",
"xfce4-notifyd",
"xfce4-panel",
"xfce4-power-manager",
"xfce4-session",
"xfce4-settings",
"xfce4-terminal",
"xfce4-whiskermenu-plugin",
"xfwm4",
"xwayland"
))

if __name__ == '__main__': 
    main()
