#!/bin/sh
dir="$(realpath $(dirname $0))/var/lib/dnf/local/"
mkdir -p "$dir"
createrepo "$dir"
zypper ref -r 'base'
