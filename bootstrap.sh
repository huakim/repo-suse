#!/bin/sh
smp="$(realpath $(dirname ${0}))"
cd "${smp}"
echo $(pwd)
dir="${smp}/bootstrap-${1}"

echo "${dir}"

if ! [ -d "${dir}" ]; then
  btrfs sub cr "${dir}" || mkdir -p "${dir}"
  btrfs sub cr "${dir}/home" ||:
fi
cp -RTfvpu bootstrap "${dir}"
cd "${dir}"

i(){
 d="${2}"
 if test -z "${d}"; then
  d="${1}"
 fi
 mkdir "${1}" -pv
 mount "/${d}" "${1}/" --bind
}

i dev
i proc
i sys

idir="extra/repo"
i "${idir}" "${smp}"

INSTALLROOT="${dir}" CACHEDIR="${smp}/pacman/var/cache/zypp" python3 "${smp}/pacman/apt-$1.py"

chroot "${dir}" /bin/bash "/${idir}/pacman/copy.sh"
chroot "${dir}" /bin/bash "/${idir}/pacman/setup.sh"
chroot "${dir}" /bin/bash "/${idir}/pacman/user.sh"
DRACUT_ARGS="${DRACUT_ARGS:-'--force-drivers usb-storage'}"
kernel_version="$(ls "${dir}/lib/modules")"
eval "chroot \"\${dir}\" /bin/dracut --kver=\"\${kernel_version}\" ${DRACUT_ARGS}"
if [ -f "${FSTAB}" ]; then
  rm -v "${dir}/etc/fstab"
  cp -v "${FSTAB}" "${dir}/etc/fstab"
  chroot "${dir}" /bin/bash "/${idir}/pacman/aptat.sh"
else
  chroot "${dir}" /bin/bash "/${idir}/pacman/aptdt.sh"
fi
umount extra/repo
umount dev proc sys
