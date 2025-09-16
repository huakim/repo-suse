#!/bin/bash -x

smp="$(realpath $(dirname ${0}))"
cd "${smp}"
dir="${smp}/bootstrap-${1}"
export INSTALLATION_VARIANT="${1}"
#echo "INSTALLATION DIRECTORY: ${dir}"

if ! [ -d "${dir}" ]; then
  btrfs sub cr "${dir}" || mkdir -p "${dir}"
  btrfs sub cr "${dir}/home" ||:
fi

cp -RTfvpu bootstrap "${dir}" ||:

cd "${dir}"

i(){
 d="${2}"
 if test -z "${d}"; then
  d="${1}"
 fi
 mkdir "${1}" -pv
 mount "/${d}" "${1}/" --bind
}


#i dev
#i proc
#i sys

idir="extra/repo"

alias chroot='systemd-nspawn -D '

#chroot . /bin/bash
#chroot . /bin/dpkg --add-architecture i386
#chroot . /bin/bash
#chroot "$dir" /sbin/dhclient
#echo "$dir"
#chroot "$dir" /bin/bash
#chroot "$dir" /bin/bash "/${idir}/pacman/aptat.sh"



DOWNLOADONLY=yes INSTALLROOT="${dir}" python3 "${smp}/pacman/apt-chroot.py" sed bash rpm coreutils
DOWNLOADONLY=no INSTALLROOT="${dir}" python3 "${smp}/pacman/apt-chroot.py" sed bash rpm coreutils

if [[ "${1}" != chroot ]]
then
i "${dir}/${idir}" "${smp}"

FORCE=yes DOWNLOADONLY=yes INSTALLROOT="${dir}" python3 "${smp}/pacman/apt-${1}.py" $EXTRAPACKAGES
chroot "${dir}" /usr/bin/env bash "/${idir}/pacman/aptat.sh"

FORCE=yes DOWNLOADONLY=no CACHEONLY=yes SPAWN="${dir}" python3 "${smp}/pacman/apt-${1}.py" $EXTRAPACKAGES

umount "${dir}/${idir}"
fi

#bash -x "${smp}/restorecon.sh" "${1}"
#umount "${dir}/${idir}"

chcon -Rv --reference=/var/lib/machines "${dir}"

i "${dir}/${idir}" "${smp}"

#touch "${dir}/.autorelabel"
#i extra "${smp}"
#chroot . /bin/bash
#chroot . /bin/bash "/extra/pacman/apt-${1}.py"
#chroot "${dir}" /bin/bash

chroot "${dir}" /usr/bin/env "$(env)" bash "/${idir}/pacman/copy.sh"
chroot "${dir}" /usr/bin/env "$(env)" bash "/${idir}/pacman/setup.sh"
chroot "${dir}" /usr/bin/env "$(env)" "DEFAULTPASSWORD=${DEFAULTPASSWORD}" "DEFAULTUSER=${DEFAULTUSER}" "USEDEFAULTS=yes" bash "/${idir}/pacman/user.sh"

#if [ -n "${INSTALL_NEW_RECOMMENDS}" ]; then
#  chroot "${dir}" /usr/bin/env zypper -C "${smp}/pacman/var/cache/zypp" --auto-agree-with-licenses --non-interactive -vvv --gpg-auto-import-keys install-new-recommends
#fi
#chroot "${dir}" /usr/bin/env "DEFAULTUSER=${DEFAULTUSER}" bash "/${idir}/pacman/tricks.sh"
#chroot . /sbin/runuser -u lenovo -c 'cd /extra/home/lenovo; ./txt.sh'
#DRACUT_ARGS="${DRACUT_ARGS:---force-drivers usb_storage}"
(
cd "${dir}"
eval "kernel_version=($(ls ./lib/modules))"
#echo "KERNEL VERSION: ${kernel_version}"
#echo "DRACUT ARGUMENTS: ${DRACUT_ARGS}"
eval "chroot . /usr/bin/env dracut --kver=${kernel_version} ${DRACUT_ARGS}"
)
if [ -f "${FSTAB}" ]; then
  rm -v "${dir}/etc/fstab"
  cp -v "${FSTAB}" "${dir}/etc/fstab"
  chroot "${dir}" /usr/bin/env bash "/${idir}/pacman/aptat.sh"
#  chroot . /usr/bin/env 'HOME=/home/lenovo' /bin/bash /extra/home/lenovo/txt.sh
else
  chroot "${dir}" /usr/bin/env bash "/${idir}/pacman/aptdt.sh"
fi

umount "${dir}/${idir}"

if [[ -z "$SKIP_RESTORECON" ]]
then
  chcon -v --reference=/ "${dir}"
  bash -x "${smp}/restorecon.sh" "${1}"
fi
