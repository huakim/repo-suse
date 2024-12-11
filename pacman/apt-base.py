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
'java-23',
'java-23-devel',
'osckit',
'luajit',
'gcc-c++',
'nim',
'tor',
'obfs4',
'glibc-locale',
'xorriso',
'mtools',
'grub2-efi',
'grub2',
'squashfs',
"git",
"tor",
"obfs4",
"squashfs",
"procps4",
"xfsprogs",
"e2fsprogs",
"efibootmgr"
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
#"efibootmgr",
"ntfs-3g",
"ntfsprogs",
"pam",
"pam-config",
"glibc-locale",
#"selinux-policy",
#"selinux-tools",
"gpm",
#"gzip",
#"iwlwifi-dvm-firmware",
#"iwlwifi-mvm-firmware",
#"e2fsprogs",
#"xfsprogs",
# EFI
#'xorriso',
#'mtools',
#'grub2-efi',
#'grub2',
#'squashfs'
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
