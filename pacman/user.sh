#!/bin/sh
user="${DEFAULTUSER:-suse}"
password='$6$iA6fDx4yzWKxy7tM$JShiydfJpce4mO28LD8pECBWFLjSG.ZMrqXFGS8pztB9T6I72NzZNBJ9PS08/xw2QLkJoJ92tAGqPZxSVv8xn1'
admin='wheel'
root='root'
shell='/bin/bash'
groupadd "$root"
groupadd "$user"
useradd "$user" -g "$user"
useradd "$root" -g "$root"
usermod -u 0 "$root"
usermod -d "/home/$user" "$user"
usermod -d "/$root" "$root"
rm -R "/$root"
groupadd netdev
groupadd plugdev
groupadd docker
groupadd "$admin"
usermod -a "$user" -G netdev
usermod -a "$user" -G plugdev
usermod -a "$user" -G docker
usermod -a "$user" -G "$admin"
usermod -s "$shell" "$user"
usermod -s "$shell" "$root"
mkhomedir_helper "$user"
mkhomedir_helper "$root"
usermod -p "$password" "$root"
usermod -p "$password" "$user"

