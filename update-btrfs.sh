#!/bin/sh

smp="$(realpath $(dirname ${0}))"

variant="${1}"
updatedir="${smp}/update-${variant}"
bootstrapdir="${smp}/bootstrap-${variant}"

(
cd "${smp}"
ROOT_FILESYSTEM="${ROOT_FILESYSTEM:-/}"
j="$(findmnt "${ROOT_FILESYSTEM}" -o uuid -n)"
is_btrfs=true

mkdir -p "${updatedir}" ||:

if mount /dev/disk/by-uuid/"$j" "${updatedir}"
then
    if [[ -d "${updatedir}/@" ]]
    then
        tmpdir="$(mktemp -d "${updatedir}/.Trash_$(date +"%Y-%m-%d_%H.%M.%S.%8N_%a")_XXXX")"
        if btrfs sub cr "${tmpdir}/@example"
        then
                mv "${updatedir}/@" "${tmpdir}/@"
                mv "${updatedir}/@home" "${tmpdir}/@home"
		btrfs sub cr "${updatedir}/@"
		btrfs sub cr "${updatedir}/@home"
		mkdir -p "${bootstrapdir}" ||:
		mount /dev/disk/by-uuid/"$j" "${bootstrapdir}" -o subvol=@
		mkdir -p "${bootstrapdir}/home" ||:
		mount /dev/disk/by-uuid/"$j" "${bootstrapdir}/home" -o subvol=@home
                export FSTAB=/etc/fstab
                export INSTALL_NEW_RECOMMENDS=yes
                . ./bootstrap.sh "${variant}"
                systemd-nspawn -D "${bootstrapdir}" /bin/bash -x -c 'mount -o remount,rw /sys/fs/selinux; restorecon -Rv /home/*'
                umount "${bootstrapdir}/home"
                umount "${bootstrapdir}"
                exit
        fi
    fi
fi

umount "${updatedir}"
exit
)
umount "${updatedir}"
umount "${bootstrapdir}"
rmdir  "${updatedir}"
rmdir  "${bootstrapdir}"
#tmpdir="$(mktemp -d "$1/.Trash-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX")"
