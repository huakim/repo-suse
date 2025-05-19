#!/bin/bash -x

smp="$(realpath $(dirname ${0}))"
cd "${smp}"
MOUNT="${smp}/bootstrap-${1}"

text='
mount -o remount,rw /sys/fs/selinux
restorecon -v /
for i in $(ls /); do
  if [[ "${i}" != "dev" ]] && [[ "${i}" != "sys" ]] && [[ "${i}" != "proc" ]] && [[ "${i}" != "run" ]]
  then
    restorecon -Rv "/${i}"
  fi
done
'

j="$(mktemp -d)"
uuid="$(findmnt -n -o uuid $MOUNT)"

if [[ -n "${uuid}" ]]
then
  mount /dev/disk/by-uuid/"${uuid}" "${j}" -o "$(findmnt -n -o options $MOUNT)"
else
  mount --bind "${MOUNT}" "${j}"
fi
systemd-nspawn -D "${j}" /bin/bash -x -c "${text}"
umount "${j}"

