#!/bin/sh
dir="$(realpath $(dirname $0))/"
dest="${1}/"

. "${dir}copy_func.sh"

parsefile "apt.list" "dirmk"
parsefile "apt.list" 'link'
echo done
