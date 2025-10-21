#!/bin/sh -x
#git pull ||:

smp="$(realpath $(dirname $0))"
cd "${smp}"

DRACUT_ARGS="--nomdadmconf --nolvmconf  --add 'livenet dmsquash-live dmsquash-live-ntfs convertfs pollcdrom qemu qemu-net' --no-hostonly --debug --no-early-microcode --force"

if test -e "bootstrap-$1"
then
  NO_DELETE_BOOTSTRAP=true
fi

if test -e "liveiso-$1"
then
  NO_DELETE_LIVEISO=true
fi

mkdir "bootstrap-$1"

sudo -E env "DRACUT_ARGS=$DRACUT_ARGS" "LIVEINSTALL=yes" "DEFAULTUSER=live" "SKIP_RESTORECON=yes" ./bootstrap.sh "$1"

i(){
 d="$2"
 if test -z "$d"; then
  d="$1"
 fi
 mkdir "$1" -pv
 mount "/$d" "$1/" --bind
}


cd "bootstrap-$1"
#i dev
#i proc
#i sys
alias chroot='systemd-nspawn -D '

i extra/repo "${smp}"

chroot "${PWD}" /bin/bash /extra/repo/pacman/copy-live.sh
chroot "${PWD}" /bin/bash /extra/repo/pacman/setup-live.sh
chroot "${PWD}" /bin/rm /root
chroot "${PWD}" /bin/cp -Rfv /etc/skel /root

umount extra/repo dev proc sys
cd ..

iso="liveiso-$1/"
dir="${iso}/LiveOS/"

mkdir -p "${dir}"

mv "$(realpath bootstrap-$1/boot/initrd)" "${dir}/initrd.img"
cp "$(realpath bootstrap-$1/boot/vmlinuz)" "${dir}/vmlinuz"

rm "${dir}/squashfs.img"

#chcon -Rv --reference=/usr "bootstrap-$1/usr"
#chcon -Rv --reference=/etc "bootstrap-$1/etc"
#systemd-nspawn -D "${PWD}/bootstrap-$1" /bin/bash -c \
#  'mount -o remount,rw /sys/fs/selinux; restorecon -Rv /afs /bin /boot /etc /home /lib /lib64 /media /mnt /opt /root /sbin /srv /tmp /usr /var'

if [[ -z "$SKIP_RESTORECON" ]]
then
  chcon -v --reference=/ "${dir}"
  bash -x "${smp}/restorecon.sh" "${1}"
fi

mksquashfs bootstrap-"$1" "${dir}/squashfs.img"

dir="${iso}/boot/grub"

if [[ -n "$(command -v grub-mkrescue)" ]]; then
  alias grub2-mkrescue=grub-mkrescue
fi

mkdir -p "${dir}"
label="LiveOS_$1_$(date +%s)"

cat <<EOF > "${dir}/grub.cfg"
function b_o_o_t{
 menuentry "\${@}"{
   shift
   linux /LiveOS/vmlinuz root=live:LABEL="${label}" security=selinux selinux=1 enforcing=0 rd.live.image rd.live.dir=/LiveOS rd.live.squashfs=squashfs.img acpi_osi=Linux psi=1 "\${@}"
   initrd /LiveOS/initrd.img
 }
}
b_o_o_t 'Live boot'
b_o_o_t 'Boot to ram' rd.live.ram=1
EOF

grub2-mkrescue -v -o "liveiso-$1.iso" -V "${label}" "${iso}"

umount bootstrap-"$1"/extra/repo
rmdir bootstrap-"$1"/extra/repo

if test -z "${NO_DELETE_BOOTSTRAP}"
then
  rm -Rfv bootstrap-"$1"
fi

if test -z "${NO_DELETE_LIVEISO}"
then
  rm -Rfv liveiso-"$1"
fi


