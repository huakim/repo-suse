#!/bin/sh
user="${DEFAULTUSER:-asus}"
password='$6$PGb.rLoofp3O3Y5a$.s0O0U2qeP3N5EIV/WawfM5.kgd9EWHY9gJxGZxBT60uY9/4qjDXtm6NB80l0OunLuvgOsc673CUKnTNoL/Qr0'
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

