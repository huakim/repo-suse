#!/bin/sh
dir="$(realpath $(dirname $0))/"
dest="${1}/"

. "${dir}copy_func.sh"

dirmk var/lib/docker
link var/lib/docker

