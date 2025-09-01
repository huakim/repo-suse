#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-rootfs.pl');
#our @pkgs;
j=__import__('apt-rootfs')
pkgs=j.pkgs
main=j.main

pkgs.extend((
"at-spi2-core",
"dosfstools",
"dracut-live",
#"grub2-efi-ia32-modules",
#"grub2-efi-x64-modules",
#"grub2-pc",
"squashfs-tools"
))
#push @pkgs, qw(

#);

pkgs.append(
"kernel-core"
)

if __name__ == '__main__': 
    main()
