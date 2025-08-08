gs='gsettings set'
v=org.gnome.nautilus.preferences
$gs $v 'default-folder-viewer' 'list-view'
$gs $v 'show-hidden-files' true

$gs org.gtk.gtk4.Settings.FileChooser 'show-hidden' true
$gs org.gtk.Settings.FileChooser 'show-hidden' true
$gs org.gnome.FileRoller.FileSelector 'show-hidden' true

v=org.gnome.Epiphany
$gs $v default-search-engine 'Google'

v=$v.web:/org/gnome/epiphany/web/
$gs $v ask-on-download true
$gs $v enable-webextensions true
$gs $v enable-adblock false
$gs $v enable-popups true
$gs $v enable-mouse-gestures true
$gs $v webextensions-active "['Dark Mode']"

desktop=org.gnome.desktop
v=$desktop.background
$gs $v picture-options 'none'
$gs $v primary-color '#130018'

$gs $desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'us+rus')]"

v=$desktop.interface
$gs $v clock-show-seconds true
$gs $v color-scheme 'prefer-dark'
$gs $v cursor-theme 'Adwaita'
$gs $v document-font-name 'Serif 11'
$gs $v enable-animations false
$gs $v font-name 'Open Sans 11'
$gs $v gtk-theme 'Adwaita-dark'
$gs $v icon-theme 'Adwaita'
$gs $v monospace-font-name 'Roboto Mono 12'

peripherals=$desktop.peripherals
v=$peripherals.keyboard
$gs $v delay 175
$gs $v repeat true
$gs $v repeat-interval 15

$gs $peripherals.mouse speed 0.8

v=$peripherals.touchpad
$gs $v click-method 'areas'
$gs $v natural-scroll false
$gs $v speed 0.8
$gs $v tap-and-drag true
$gs $v tap-to-click true
$gs $v two-finger-scrolling-enabled true

windowmanager=$desktop.wm
v=$windowmanager.keybindings
$gs $v switch-input-source "['<Shift>Alt_L']"
$gs $v switch-input-source-backward "['<Alt>Shift_L']"

v=$windowmanager.preferences
$gs $v button-layout "close,minimize,maximize:"
$gs $v theme "Adwaita"

$gs org.gnome.mutter attach-modal-dialogs false

v=org.gnome.settings-daemon.plugins.color
$gs $v night-light-enabled true
$gs $v night-light-schedule-automatic false
$gs $v night-light-schedule-from 0
$gs $v night-light-schedule-to 0

v=org.gnome.shell
$gs $v enabled-extensions "['Onboard_Indicator@onboard.org', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-dock@micxgx.gmail.com', 'unite@hardpixel.eu', 'ding@rastersoft.com', 'gsconnect@andyholmes.github.io']"
$gs $v favorite-apps "[]"

v=$v.extensions
e=$v.gtk4-ding
$gs $e icon-size 'small'


e=$v.ding
$gs $e show-home false
$gs $e show-trash false
$gs $e show-volumes false
$gs $e add-volumes-opposite false

e=$v.dash-to-dock
$gs $e always-center-icons true
$gs $e animation-time 0
$gs $e apply-custom-theme true
#$gs $e autohide true
$gs $e autohide false
$gs $e autohide-in-fullscreen false
#$gs $e autohide-in-fullscreen true
$gs $e custom-theme-shrink true
$gs $e dash-max-icon-size 27
$gs $e dock-fixed true
$gs $e dock-position 'LEFT'
#$gs $e dock-position 'BOTTOM'
$gs $e extend-height true
#$gs $e extend-height false
#$gs $e intellihide true
#$gs $e intellihide-mode true
$gs $e show-mounts false
$gs $e show-mounts-only-mounted false
$gs $e show-trash false

v=org.nemo.preferences
$gs $v show-hidden-files true
$gs $v default-folder-viewer 'list-view'
$gs $v date-format 'iso'
$gs $v thumbnail-limit '102400'

e=$v.menu-config
s='selection-menu'
$gs $e $s-copy-to true
$gs $e $s-duplicate true
$gs $e $s-make-link true
$gs $e $s-move-to true

