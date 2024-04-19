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
'labwc','libjack','geany',
'adobe-sourcecodepro-fonts',
'adobe-sourcesanspro-fonts',
'adobe-sourceserifpro-fonts',
'bc','brightnessctl',
'cantarell-fonts','clipman',
'cnf','dejavu-fonts',
'fontawesome-fonts','gfxboot',
'gfxboot-branding-openSUSE', 
'ghostscript-fonts-other', 
'ghostscript-fonts-std',
'google-carlito-fonts', 
'google-droid-fonts',
'google-noto-coloremoji-fonts', 
'google-noto-sans-fonts', 
'google-roboto-fonts',
'granite-common', 'grim', 
'gsettings-desktop-schemas', 
'gtk3-metatheme-adwaita', 'gtkgreet',
'metatheme-adwaita-common',
'pavucontrol', 'waybar',
'playerctl', 'polkit-gnome', 'slurp',
'wl-clipboard', 'wob', 'wofi',
'xdg-desktop-portal', 'bemenu',
'xdg-desktop-portal-gtk', 'xdg-desktop-portal-wlr'
))

pkgs.extend((
#'kmail-account-wizard',
#'qt5-qtwebengine-devtools',
#'falkon',
#'kmail'
))

if __name__ == '__main__':
    main()
