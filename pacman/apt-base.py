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

if env.check("LIVEINSTALL"):
    pkgs.append('grub2')
    for i in ['', '-extras']:
        for u in ['x86_64', 'i386']:
            for c in ['efi', 'xen', 'pc']:
                if c == 'pc':
                    if u != 'i386':
                        continue
                pkgs.append('grub2-' + u + '-' + c + i)

if env.check('EXTRAINSTALL'):
    pkgs.extend((
'java',
'java-devel',
'osckit',
'luajit',
'gcc-c++',
'nim',
'tor',
'maven',
'obfs4',
'glibc-locale',
'xorriso',
'mtools',
'proxychains-ng',
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

if not env.check("SKIPKERNEL"):
    pkgs.extend((
#"intel-compute-runtime",
"kernel-default",
"kexec-tools",
#"Mesa",
#"Mesa-dri",
#"nvidia-gpu-firmware",
#"kernel-firmware-realtek",
#"kernel-firmware-iwlwifi",
#"bluez-firmware",
#"kernel-firmware-bluetooth"
))

if __name__ == '__main__':
    main()
