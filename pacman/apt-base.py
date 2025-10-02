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
    pkgs.extend(['yast2-' + i for i in ['packager', 'bootloader', 'users']])

if env.check("FLATSERVERINSTALL"):
    pkgs.extend((
        'patterns-xfce-xfce_extra',
        'wine-stable',
        'waydroid-image',
        'waydroid-magisk',
        'patterns-containers-container_runtime',
        'patterns-cockpit',
        'patterns-yast-yast2_server',
        'patterns-yast-yast2_desktop',
        'patterns-devel-java-devel_java',
        'patterns-devel-C-C++-devel_C_C++',
        'patterns-base-selinux',
        'patterns-base-console',
        'patterns-server-kvm_server',
        'patterns-server-kvm_tools',
        'codium'
    ))

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
#'osckit',
'luajit',
'gcc-c++',
'nim',
'clang',
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
#"dracut-kiwi-live",
#"dracut-live",
"exfatprogs",
#"efibootmgr",
"ntfs-3g",
"dislocker",
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
"patterns-base-selinux",
"selinux-policy-targeted",
"selinux-targeted-setup",
"selinux-tools",
"selinux-autorelabel"
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
