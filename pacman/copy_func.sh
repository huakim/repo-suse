#!/bin/sh

bkup(){
  l="$dir" dir="$dest" dest="$l" copy "$1" "$2"
}

copy(){
  f="$dest${2:-$1}"
  d="$(dirname "$f")"
  mkdir -p -v "$d"
  cp -RTfv "$dir$1" "$f"
}

dirmk(){
 mkdir -pv "$dir$1"
}

link(){
 f="$dest${2:-$1}"
 rm -Rfv "$f"
 d="$(dirname "$f")"
 mkdir -p -v "$d"
 ln -sTfv "$dir$1" "$f"
}

rlnk(){
 f="$dest$2"
 rm -Rfv "$f"
 ln -sTfv "$1" "$f"
}

cldir(){
 f="$dest${1}"
 rm -Rvf "$f"
 mkdir -p "$f"
}

parse(){
  while read line; do
    $1 $line
  done
}

parsevar(){
    echo "$1" | parse "$2"
}

parsefile(){
    sed -n '/^[[:space:]]*#/!{/^[[:space:]]*$/!p}' "$dir$1" | parse "$2"
}
