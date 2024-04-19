#!/bin/sh

. "${dir}copy_func.sh"

echo_pacman(){
    echo -n '../'
    echo "${@}"
}
listfiles="$(
parsefile "extra.list" echo_pacman

for i in 'copy' 'copy-live' 'script' 'aptl' ; do
    parsefile "${i}.list" echo
done
)"
