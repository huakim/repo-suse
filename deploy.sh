#!/bin/sh
smp="$(realpath $(dirname ${0}))"
cd "${smp}"
dir="${smp}/bootstrap-${1}"
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
echo "OPTIONS=\"\${OPTIONS} root=PARTUUID=${ROOT_PARTITION} psi=1\"" > "${smp}/options"

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

FSTAB="${smp}/fstab" ${smp}/bootstrap.sh "$1"

. "${smp}/options"
if [[ -n "${EFI_PARTITION}" ]]
then
echo "PARTUUID=${EFI_PARTITION} /boot/efi vfat umask=077 0 2" >> "${smp}/fstab"
efidir="${dir}/boot/efi"
mkdir -p "${efidir}"
mount /dev/disk/by-partuuid/$EFI_PARTITION "${efidir}"
refind-install --root "${dir}"
for i in refind BOOT
do
    confdir="${efidir}/EFI/${i}"
    if [[ -d "${confdir}" ]]
    then
        conf="${confdir}/refind.conf"
        icon="${confdir}/icons/os_suse.png"
    fi
done
cat << EOF > "$conf"
menuentry SuSE {
icon ${icon}
volume $ROOT_PARTITION
loader $rootdir/vmlinuz
initrd $rootdir/initrd.img
options "${OPTIONS}"
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
