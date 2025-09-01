#!/bin/sh
dir="$(realpath $(dirname $0))/"
dest="${1}/"

. "${dir}copy_func.sh"

parsefile 'apt.list' 'cldir'
parsefile 'aptl.list' 'copy'
