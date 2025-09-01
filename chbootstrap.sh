#!/bin/bash
#dhclient

smp="$(realpath $(dirname $0))"
cd "${smp}"
echo $(pwd)
dir="bootstrap-$1"
cd "$dir"

i(){
 d=$2
 if test -z $d; then
  d=$1
 fi
 echo $d
 mkdir $1 -pv
 mount /$d $1/ --bind
}


i dev
i proc
i sys
i extra "${smp}"
chroot . /bin/bash
umount dev proc sys extra
