echo "Storage=volatile" >> /etc/systemd/journald.conf

#chkstat --system --set

sed -i -e 's,^\(.*pam_gnome_keyring.so.*\),#\1,'  /etc/pam.d/common-auth-pc
echo '127.0.0.2       live.site live' >> /etc/hosts

ln -s /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target

/usr/sbin/useradd -m -u 1000 suse -c "Live-CD User" -p ""
echo "live ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/50-livecd
passwd -d root
passwd -d live
# empty password is ok
#pam-config -a --nullok
#systemctl disable relabel-selinux


#if [[ "$(getconf LONG_BIT)" == 64 ]]; then
#  lib=/usr/lib64
#else
#  lib=/usr/lib
#fi

#clm="${lib}"/calamares/modules
#mkdir -p "${clm}/linkoverlay"
#cat << EOF > "${clm}/linkoverlay/module.desc"
# SPDX-FileCopyrightText: no
# SPDX-License-Identifier: CC0-1.0
#---
#type:       "job"
#name:       "linkoverlay"
#interface:  "python"
#script:     "main.py"
#noconfig:   true
#EOF

#cat << EOF > "${clm}/linkoverlay/main.py"
#import os
#def run():
#  try: os.symlink('.', '/run/overlay')
#  except FileExistsError: pass
#  try: os.system('systemctl enable relabel-selinux')
#  except Exception: pass
#EOF

a=DISPLAYMANAGER_AUTOLOGIN
sed -i "s/^${a}=.*/${a}=live/g;" '/etc/sysconfig/displaymanager'
