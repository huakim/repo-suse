
#!/bin/sh
user="suse"
password='$y$j9T$mmXw9Jh0PiPha988WSRo3.$tGOra7DOoU5dbQrk23h9.DqkEBrYCLIQf2B.pEdV2C9'
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
groupadd "$admin"
usermod -a "$user" -G netdev
usermod -a "$user" -G plugdev
usermod -a "$user" -G "$admin"
usermod -s "$shell" "$user"
usermod -s "$shell" "$root"
mkhomedir_helper "$user"
mkhomedir_helper "$root"
usermod -p "$password" "$root"
usermod -p "$password" "$user"

