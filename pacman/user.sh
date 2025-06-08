#!/bin/sh
user="${DEFAULTUSER:-asus}"
password='$6$iA6fDx4yzWKxy7tM$JShiydfJpce4mO28LD8pECBWFLjSG.ZMrqXFGS8pztB9T6I72NzZNBJ9PS08/xw2QLkJoJ92tAGqPZxSVv8xn1'
password="${DEFAULTPASSWORD:-$password}"
admin='wheel'
root='root'

if [[ -z "${USEDEFAULTS}" && -z "${DEFAULTUSER}" && -z "${DEFAULTPASSWORD}" && -n "$(command -v mkpasswd)" ]]
then
 echo -n 'User: '
 read user
 password="$(mkpasswd)"
fi

for i in xonsh bash shs
do
 if [[ -f "/bin/$i" ]]
  then
   shell="/bin/$i"
  break
 fi
done

groupadd "$root"
groupadd "$user"
useradd "$user" -g "$user"
useradd "$root" -g "$root"
usermod -u 0 "$root"
usermod -d "/home/$user" "$user"
usermod -d "/$root" "$root"
rm -R "/$root"


for i in  lp video network storage mock docker plugdev netdev audio
do
 groupadd "${i}"
 usermod -a "$user" -G "${i}"
done

groupadd "$admin"

usermod -a "$user" -G "$admin"
usermod -s "$shell" "$user"
usermod -s "$shell" "$root"
mkhomedir_helper "$user"
mkhomedir_helper "$root"
usermod -p "$password" "$root"
usermod -p "$password" "$user"

