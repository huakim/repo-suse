#!/bin/sh

dir="$(realpath $(dirname $0))/var/lib/apt/local/pool/makedeb/"
mkdir "${dir}" -p

(
build='build'
git='git'

cd "${dir}"
mkdir "${git}"
mkdir "${build}"

base="${1}"
shift;
url="https://mpr.makedeb.org/${base}"

cd "${git}"
git clone "${url}"
cd ..

mkdir -p "./${build}/${base}"
cp -RfT "./${git}/${base}" "./${build}/${base}"
cd "./${build}/${base}"
makedeb -s  --danger "${@}"
)
