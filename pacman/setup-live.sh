echo "Storage=volatile" >> /etc/systemd/journald.conf

chkstat --system --set

sed -i -e 's,^\(.*pam_gnome_keyring.so.*\),#\1,'  /etc/pam.d/common-auth-pc
echo '127.0.0.2       linux.site linux' >> /etc/hosts

ln -s /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target


/usr/sbin/useradd -m -u 1000 suse -c "Live-CD User" -p ""
echo "linux ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/50-livecd
passwd -d root
passwd -d suse
# empty password is ok
pam-config -a --nullok
