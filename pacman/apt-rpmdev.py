#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-chroot.pl');
#our @pkgs;

j=__import__('apt-chroot')
pkgs=j.pkgs
main=j.main

pkgs.extend((
'rpm-build',
'rpmdevtools'
))

if __name__ == '__main__': 
    main()

