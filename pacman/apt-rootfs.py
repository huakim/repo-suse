#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-chroot.pl');
#our @pkgs;
j=__import__('apt-chroot')
pkgs=j.pkgs
main=j.main



if pkgs[0] == 'dnf5':
    dnfplugins=('dnf5-plugins',)
else:
    dnfplugins=[]

pkgs.extend(dnfplugins)

# push @pkgs, qw(
pkgs.extend((
"fwupd",
"aha",
"branding-upstream",
"ca-certificates",
"ca-certificates-mozilla",
"glibc-i18ndata",
"lsb-release",
"wpa_supplicant",
"NetworkManager",
"bind-utils",
"diffutils",
"ca-certificates",
"coreutils",
"dhcp-client",
#"dnf-command(config-manager)",
#"dnf-command(versionlock)",
"fakeroot",
"file",
"glibc",
"glibc-locale-base",
#"gmp",
"hostname",
"inotify-tools",
"less",
"lsof",
"nano",
"ncurses",
"net-tools",
"openssh",
"pciutils",
"psmisc",
"rsync",
"sed",
"selinux-policy",
"selinux-tools",
"shadow",
"sudo",
"systemd",
"systemd-container",
"kmod",
#"tzdata",
"tar",
"gzip",
"unzip",
"udisks2",
"wget",
"which",
"whois"
))
# );

if __name__ == '__main__':
    main()

# unless (caller){
    # load(@ARGV);
# }

