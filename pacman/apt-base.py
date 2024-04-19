#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-rootfs.pl');
#our @pkgs;
j=__import__('apt-rootfs')
pkgs=j.pkgs
main=j.main

pkgs.extend((
"NetworkManager-bluetooth",
"NetworkManager-wifi",
"NetworkManager-openvpn",
"at-spi2-core",
"btrfs-progs",
"bluez-obexd",
"dosfstools",
"dracut-kiwi-live",
#"dracut-live",
"efibootmgr",
"ntfs-3g",
"ntfsprogs",
#"rEFInd",
"pam",
"pam-config",
"procps4",
"squashfs",
"tor",
"obfs4",
#"selinux-policy",
#"selinux-tools",
"gpm",
#"gzip",
#"iwlwifi-dvm-firmware",
#"iwlwifi-mvm-firmware",
"e2fsprogs",
"xfsprogs"
))
#push @pkgs, qw(

#);

pkgs.extend((
#"intel-compute-runtime",
"kernel-default",
"kexec-tools",
"Mesa",
"Mesa-dri",
#"nvidia-gpu-firmware",
"kernel-firmware-realtek",
"kernel-firmware-iwlwifi",
"bluez-firmware",
"kernel-firmware-bluetooth"
))

if __name__ == '__main__': 
    main()
