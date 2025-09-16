#!/bin/sh
cd "$(realpath $(dirname $0))"

clone(){
 mkdir ./"$1" -pv
 rm -Rvf "$HOME/$2"
 mkdir "$HOME"/"$(dirname $1)" -pv
 ln -sfTv %/"$1" "$HOME/$2"
}

fclone(){
 mkdir ./"$(dirname $1)" -pv
 touch ./"$1"
 rm -Rvf "$HOME/$2"
 mkdir "$HOME"/"$(dirname $1)" -pv
 ln -sfTv %/"$1" "$HOME/$2"
}

copy(){
 rm -Rvf "$HOME/$1"
 mkdir "$HOME/$(dirname $1)" -pv
 cp -fTv %/"$1" "$HOME/$1"
}

link(){
 clone "$1" "$1"
}

flink(){
 fclone "$1" "$1"
}

rtl(){
 mkdir -pv "$HOME/$1"
 ln -sfTv ../% "$HOME/$1/%"
}

ln -sfTv "$(pwd)" "$HOME/%"
rtl .local
rtl .config
rtl .cache
rtl .local/share
rtl .local/share/KDE
rtl .config/KDE
rtl .wine

link "Downloads"
link "Desktop"
link "Documents"
link "Pictures"
link "Public"
link "Templates"
link "Videos"
link "Screenshots"
link "go"
link "Screencasts"
link "Music"
#link "Workspace"
link ".android"
link ".anydesk"
link "perl5"
link rpmbuild
link Android
link .cargo
link .npm
#link .cache/accountwizard
link .cache/ZapZap
link .cache/chromium
link .cache/Eclipse
link .cache/epiphany
link .cache/evolution
link .cache/falkon
#link .cache/kmail2
link .cache/netbeans
link .cache/floorp
link .cache/librewolf
link .cache/mozilla
link .cache/waterfox
link .cache/wine
link .cache/winetricks
link .cache/Tangram
link .cache/geary
link .cache/waydroid-script
#link .config/akonadi
flink .config/copr
flink .config/KDE/neochat.conf
link .config/ZapZap
link .config/VSCodium
clone .config/VSCodium .config/VSCode
clone .config/VSCodium .config/Code
link .config/nekoray
clone .config/nekoray .config/Throne
clone .config/nekoray .config/nekobox
link .config/chromium
link .config/clangd
link .config/azahar-emu
link .config/discord
link .config/epiphany
link .config/evolution
link .config/falkon
link .config/libreoffice
link .vscode-oss
clone .vscode-oss .vscode
link .varia
link .xdm-app-data
link .eclipse
link .egradle
link .composer
link .gradle
#link .local/share/akonadi
#link .local/share/akonadi_migration_agent
#link .local/share/contacts
#link .local/share/emailidentities
link .local/share/ZapZap
link .local/share/azahar-emu
link .local/share/KDE/neochat
link .local/share/epiphany
link .local/share/evolution
link .local/share/geary
link .local/var/pmbootstrap
link .local/share/Steam
#link .local/share/kontact
#link .local/share/local-mail
link ".local/share/64Gram"
link ".local/share/Tangram"
#link ".local/share/tmulti"
#link ".local/share/waydroid"
link ".netbeans"
link ".m2"
link ".ssh"
link ".floorp"
clone ".floorp" ".zen"
link ".nimble"
link ".librewolf"
link ".mozilla"
link ".waterfox"
link ".wine/drive_c"
link "VirtualBox VMs"
link "Workspace"

clone ".local/share/64Gram" ".local/share/TelegramDesktop"
clone ".local/share/64Gram" ".local/share/AyuGramDesktop"
clone "Workspace" "workspace"
clone "Workspace" "projects"
clone "Workspace" "Projects"
clone "Workspace" "NetBeansProjects"
clone "Workspace" "AndroidStudioProjects"
clone "Workspace" "IntelliJIDEAProjects"

link "waydroid"
clone "waydroid" ".local/share/waydroid"

