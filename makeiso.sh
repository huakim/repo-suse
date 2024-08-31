#!/bin/sh
DRACUT_ARGS="--nomdadmconf --nolvmconf  --add 'livenet dmsquash-live dmsquash-live-ntfs convertfs pollcdrom qemu qemu-net' --no-hostonly --debug --no-early-microcode --force"

if [[ -e "bootstrap-$1" ]]
then
  NO_DELETE_BOOTSTRAP=true
fi

if [[ -e "liveiso-$1" ]]
then
  NO_DELETE_LIVEISO=true
fi

sudo env "DRACUT_ARGS=$DRACUT_ARGS" "LIVEINSTALL=yes" "DEFAULTUSER=linux" ./bootstrap.sh "$1"

smp="$(realpath $(dirname $0))"
cd "${smp}"

i(){
 d="$2"
 if test -z "$d"; then
  d="$1"
 fi
 mkdir "$1" -pv
 mount "/$d" "$1/" --bind
}


cd "bootstrap-$1"
i dev
i proc
i sys
i extra/repo "${smp}"

chroot . /bin/bash /extra/repo/pacman/copy-live.sh
chroot . /bin/bash /extra/repo/pacman/setup-live.sh

umount extra/repo dev proc sys
cd ..

iso="liveiso-$1/"
dir="${iso}/LiveOS/"

mkdir -p "${dir}"

mv "$(realpath bootstrap-$1/initrd.img)" "${dir}/initrd.img"
cp "$(realpath bootstrap-$1/vmlinuz)" "${dir}/vmlinuz"

rm "${dir}/squashfs.img"
mksquashfs bootstrap-"$1" "${dir}/squashfs.img"

GR="$(command -v grub2-mkrescue)"
dir="${iso}/boot/grub"

if [ -z "${GR}" ]; then
  GR="$(command -v grub-mkrescue)"
fi

mkdir -p "${dir}"
label="LiveOS_$1_$(date +%s)"

cat <<EOF > "${dir}/grub.cfg"
function b_o_o_t{
 menuentry "\${@}"{
   shift
   linux /LiveOS/vmlinuz root=live:LABEL="${label}" rd.live.image rd.live.dir=/LiveOS rd.live.squashfs=squashfs.img acpi_osi=Linux psi=1 "\${@}"
   initrd /LiveOS/initrd.img
 }
}
b_o_o_t 'Boot to ram' rd.live.toram=1
b_o_o_t 'Live boot'
EOF

"$GR" -v -o "liveiso-$1.iso" -V "${label}" "${iso}"

if [[ -z "${NO_DELETE_BOOTSTRAP}" ]]
then
  rm -Rfv bootstrap-"$1"
fi

if [[ -z "${NO_DELETE_LIVEISO}" ]]
then
  rm -Rfv liveiso-"$1"
fi


