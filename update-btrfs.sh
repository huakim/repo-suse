#!/bin/sh
smp="$(realpath $(dirname ${0}))"
cd "${smp}"

j="$(findmnt / -o uuid -n)"
is_btrfs=true

variant="${1}"
updatedir="${smp}/update-${variant}"
mkdir -p "${updatedir}" ||:

mount /dev/disk/by-uuid/"$j" "${updatedir}" && (
    if [[ -d "${updatedir}/@" ]]
    then
        tmpdir="$(mktemp -d "${updatedir}/.Trash-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX")"
        if [[ -d "${updatedir}/@backup/repo" ]]
        then
            btrfs sub cr "${tmpdir}/@example" && (
                mv "${updatedir}/@" "${tmpdir}/@"
                mv "${updatedir}/@home" "${tmpdir}/@home"
		btrfs sub cr "${updatedir}/@"
		btrfs sub cr "${updatedir}/@home"
		mkdir -p "${smp}/bootstrap-${variant}" ||:
		mount /dev/disk/by-uuid/"$j" "${smp}/bootstrap-${variant}" -o subvol=@
		mkdir -p "${smp}/bootstrap-${variant}/home" ||:
		mount /dev/disk/by-uuid/"$j" "${smp}/bootstrap-${variant}/home" -o subvol=@home
                FSTAB=/etc/fstab
                INSTALL_NEW_RECOMMENDS=yes
                . ./bootstrap.sh "${variant}"
                umount "${smp}/bootstrap-${variant}/home"
                umount "${smp}/bootstrap-${variant}"
            )
        fi
    fi
)

umount "${updatedir}"
rmdir "${updatedir}"
#tmpdir="$(mktemp -d "$1/.Trash-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX")"
