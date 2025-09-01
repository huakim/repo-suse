#!/bin/sh

dir="$(realpath $(dirname $0))/var/lib/apt/local/pool/makedeb/"
mkdir "${dir}" -p

(
build='main'
cd "${dir}"
git clone https://github.com/bunnylo1/makedeb main
cd main
make build
)
