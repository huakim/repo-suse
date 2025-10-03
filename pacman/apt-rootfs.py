#!/bin/python3
#use File::Basename;
#use File::Spec;
#require File::Spec->catfile(dirname(__FILE__), 'apt-chroot.pl');
#our @pkgs;
j=__import__('apt-chroot')
pkgs=j.pkgs
main=j.main
env=j.env

if env.check("FLATSERVERINSTALL"):
  j.os.environ["EXTRAINSTALL"] = 'yes'

if pkgs[0] == 'dnf5':
    dnfplugins=('dnf5-plugins',)
else:
    dnfplugins=[]

pkgs.extend(dnfplugins)

if env.check("SELINUX"):
    pkgs.extend((
"selinux-policy",
"selinux-tools"
))

if env.check('EXTRAINSTALL'):
    pkgs.extend((

"fakeroot",
"file",
#"nano",
#"ncurses",
"net-tools",
"openssh",
"pciutils",
"psmisc",
"rsync",
#"sed",
"tar",
"gzip",
"unzip",
"wget",
"which",
"whois",
#'unrar',
'p7zip-full',
"bind-utils",
"diffutils",
"coreutils"
))

# push @pkgs, qw(
pkgs.extend((
"fwupd",
"aha",
"nano",
"ncurses",
"sed",
"branding-upstream",
"ca-certificates",
"ca-certificates-mozilla",
"glibc-i18ndata",
"lsb-release",
"wpa_supplicant",
"NetworkManager",
#"bind-utils",
#"diffutils",
#"ca-certificates",
#"coreutils",
#"dhcp-client",
#"dnf-command(config-manager)",
#"dnf-command(versionlock)",
"glibc",
"glibc-locale-base",
#"gmp",
"hostname",
"inotify-tools",
"less",
"lsof",
#"selinux-policy",
#"selinux-tools",
"shadow",
"sudo",
"systemd",
"systemd-container",
"kmod",
#"tzdata",
"udisks2",
"device-mapper"
))
# );

if __name__ == '__main__':
    main()

# unless (caller){
    # load(@ARGV);
# }

