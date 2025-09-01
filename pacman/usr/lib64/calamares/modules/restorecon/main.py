import subprocess
import libcalamares
def run():
    pwd = libcalamares.globalstorage.value('rootMountPoint')
    subprocess.Popen(['env', 'MOUNT=' + pwd, 'bash', '-xc', """
text='
restorecon -v /
for i in $(ls /); do
  if [[ "$i" != "dev" ]] && [[ "$i" != "sys" ]] && [[ "$i" != "proc" ]] && [[ "$i" != "run" ]]
  then
    restorecon -Rv "/$i"
  fi
done
'

j="$(mktemp -d)"

mount /dev/disk/by-uuid/"$(findmnt -n -o uuid $MOUNT)" "${j}" -o "$(findmnt -n -o options $MOUNT)"

systemd-nspawn -D "${j}" /bin/bash -x -c "mount -o remount,rw /sys/fs/selinux; $text"

umount "${j}"
"""]).wait()


