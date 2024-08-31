#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-rootfs.pl');
#our @pkgs;
j=__import__('apt-rootfs')
pkgs=j.pkgs
main=j.main
env=j.env

if pkgs[0] == 'zypper':
    pkgs.append('yast2-packager')

if env.check('EXTRAINSTALL'):
    pkgs.extend((
'java',
'java-devel',
'luajit',
))

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
"exfatprogs",
"efibootmgr",
"ntfs-3g",
"ntfsprogs",
"rEFInd",
"pam",
"pam-config",
"procps4",
"squashfs",
"tor",
"obfs4",
"glibc-locale",
#"selinux-policy",
#"selinux-tools",
"gpm",
#"gzip",
#"iwlwifi-dvm-firmware",
#"iwlwifi-mvm-firmware",
"e2fsprogs",
"xfsprogs",
# EFI
'xorriso',
'mtools',
'grub2-efi',
'grub2',
'squashfs'
))
#push @pkgs, qw(

#);

pkgs.extend((
#"intel-compute-runtime",
"kernel-default",
"kexec-tools",
#"Mesa",
#"Mesa-dri",
#"nvidia-gpu-firmware",
#"kernel-firmware-realtek",
"kernel-firmware-iwlwifi",
#"bluez-firmware",
#"kernel-firmware-bluetooth"
))

if __name__ == '__main__':
    main()
