#!/bin/sh
smp="$(realpath $(dirname ${0}))"
cd "${smp}"
dir="${smp}/bootstrap-${1}"
(
mkdir -p "${dir}"
#ROOT_PARTITION
#SWAP_PARTITION
#EFI_PARTITION
#EXTRA_PARTITION

EXTRA_PARTITION="${EXTRA_PARTITION:-"${ROOT_PARTITION}"}"

if [[ -z "${ROOT_PARTITION}" ]]
then
exit 1
fi

t="$(mktemp -d /tmp/XXXXXXXXXXXXXXXXXXXXXXXXXXXXX)"

(
chmod 700 "$t"
rm "${smp}/fstab"
echo "OPTIONS=\"\${OPTIONS} root=PARTUUID=${ROOT_PARTITION} mitigations=auto security=selinux selinux=1 acpi_osi=Linux psi=1 intel_iommu=on\"" > "${smp}/options"

if [[ -n "${SWAP_PARTITION}" ]]
then
echo "PARTUUID=${SWAP_PARTITION} swap swap defaults 0 0" >> "${smp}/fstab"
echo "OPTIONS=\"\${OPTIONS} resume=PARTUUID=${SWAP_PARTITION}\"" >> "${smp}/options"
fi

moveall(){
    (
        shopt -s dotglob
        tmpdir="$(mktemp -d "$1/.Trash-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX")"
        for i in "$1"/*
        do
            if [[ "$tmpdir" != "$i" ]]
            then
                mv "$i" "$tmpdir"
            fi
        done
    )
}

mountandclean(){
    mkdir -p "$t/$2"
    mount /dev/disk/by-partuuid/$1 "$t/$2"
    moveall "$t/$2"
}

copyextra(){
    (
        cd ${smp}
        . ${smp}/copy-extra.sh "$1"
        if [[ -n "$COPY_EXTRA_FILES" ]]
        then
            . ${smp}/pacman/aptcp.sh "$1"/pacman
        fi
    )
}


mountandclean "$ROOT_PARTITION" "root"
mountandclean "$EXTRA_PARTITION" "extra"

(
cd "$t/root"
btrfs sub cr @cache    && \
btrfs sub cr @log      && \
btrfs sub cr @         && \
btrfs sub cr @/home    && \
(
mount /dev/disk/by-partuuid/$ROOT_PARTITION "${dir}" -o subvol=/@
echo "is_btrfs=1" >> "${smp}/options"
echo "
PARTUUID=${ROOT_PARTITION} /                   btrfs   subvol=/@,defaults,compress=zstd:1 0 0
PARTUUID=${ROOT_PARTITION} /home               btrfs   subvol=/@home,defaults,compress=zstd:1 0 0
PARTUUID=${ROOT_PARTITION} /var/cache          btrfs   subvol=/@cache,defaults,compress=zstd:1 0 0
PARTUUID=${ROOT_PARTITION} /var/log            btrfs   subvol=/@log,defaults,compress=zstd:1 0 0
" >> "${smp}/fstab"
echo "rootdir=/@; OPTIONS=\"\${options} rootfstype=btrfs rootflags=subvol=/@\"" >> "${smp}/options"
)

) || (
mount /dev/disk/by-partuuid/$ROOT_PARTITION "${dir}"
echo "is_btrfs=0" >> "${smp}/options"
echo "
PARTUUID=${ROOT_PARTITION} /                   auto    defaults 0 0
" >> "${smp}/fstab"
)

(
cd "$t/extra"
btrfs sub cr @backup  && \
(
copyextra "$t/extra/@backup/repo"
echo "
PARTUUID=${EXTRA_PARTITION} /extra              btrfs   subvol=/@backup,defaults,compress=zstd:1 0 0
" >> "${smp}/fstab"
)

) || (
copyextra "$t/extra/repo"
echo "
PARTUUID=${EXTRA_PARTITION} /extra              auto    defaults 0 0
" >> "${smp}/fstab"
)

)

FSTAB="${smp}/fstab"
FORCE=yes
. ${smp}/bootstrap.sh "$1"

. "${smp}/options"
if [[ -n "${EFI_PARTITION}" ]]
then
echo "PARTUUID=${EFI_PARTITION} /boot/efi vfat umask=077 0 2" >> "${smp}/fstab"
efidir="${dir}/boot/efi"
mkdir -p "${efidir}"
mount /dev/disk/by-partuuid/$EFI_PARTITION "${efidir}"

MACHINE_TYPE=`uname -m`

if [[ "$MACHINE_TYPE" == "i686" ]]
then
MACHINE_TYPE=i386
fi

if [[ "$MACHINE_TYPE" == "i586" ]]
then
MACHINE_TYPE=i386
fi

if [[ "$MACHINE_TYPE" == "i486" ]]
then
MACHINE_TYPE=i386
fi

grub2-install --efi-directory "${efidir}" --boot-directory "${efidir}" --removable --target="${MACHINE_TYPE}-efi"
conf="${efidir}/grub2/grub.cfg"

ROOT_UUID=$(blkid | grep "$ROOT_PARTITION" | awk -F ' ' '{print $2}' | sed 's/UUID="//;s/"//')

cat << EOF > "$conf"
menuentry SuSE {
search --fs-uuid --set=root ${ROOT_UUID}
linux ${rootdir}/boot/vmlinuz ${OPTIONS} root=UUID="${ROOT_UUID}"
initrd ${rootdir}/boot/initrd
}
EOF

umount "${efidir}"
umount "${dir}"
fi

if (( "$is_btrfs" == 1 ))
then
(
cd "$t/root"
mv @/home @home
)
fi

umount "$t/root" "$t/extra"
)
umount "${dir}"
rmdir "${dir}" ||:
