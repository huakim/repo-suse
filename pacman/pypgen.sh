#!/bin/sh

dir="$(realpath $(dirname $0))/var/lib/dnf/local/python3/"
mkdir "${dir}/rpmbuild/SPECS" -p
mkdir "${dir}/rpmbuild/SRPMS" -p
mkdir "${dir}/rpmbuild/RPMS" -p

build(){
    (
    cd "${dir}"
    pyp2rpm "$1" > "rpmbuild/SPECS/$1.spec"
    HOME="${dir}" spectool -g -R "rpmbuild/SPECS/$1.spec"
    HOME="${dir}" rpmbuild -bs "rpmbuild/SPECS/$1.spec"
#    ls
#    cat "$1.spec"
  #  pyp2rpm "$1" > "$1.spec"
    )
}

for i in "${@}"; do
   build "$i"
done
