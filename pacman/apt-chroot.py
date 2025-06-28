#!/bin/python3
import os
import re
import subprocess
import sys
relver=re.compile('^(.*releasever.*)$', re.MULTILINE)
relatr=re.compile('.*=\s*(.*)')

def chstr(a):
    if a == None or a == False or a == 0 or a == '':
        return False
    else:
        return True

def check(a):
    if not chstr(a) or a == 'None' or a == 'False' or a == '0':
        return False
    else:
        return True

env=type('env',(), {'__call__': staticmethod(os.environ.get),
'check': lambda self, a: check(self(a)), 'chstr': lambda self, a: chstr(self(a))})()

pkgs = []

def ZYPPER_CONFIG():
        INSTALLROOT=env('INSTALLROOT')
        INTERACTIVE=check(env('INTERACTIVE'))
        QUIET=env('QUIET')
        NOGPGCHECK=check(env('NOGPGCHECK'))
        RECOMMENDS=env('RECOMMENDS')
        DOCS=env('DOCS')
        DOWNLOADONLY=env('DOWNLOADONLY')
        CACHEDIR=env('CACHEDIR')
        LIBDIR=env('LIBDIR')
        FORCE=env
        RELEASEVER=env('RELEASEVER')
        CACHEONLY=env('CACHEONLY')
        flags = ['zypper']
        if not check(INTERACTIVE):
            flags.extend(('--non-interactive',
            '--gpg-auto-import-keys'))
        if check(NOGPGCHECK):
            flags.append('--no-gpg-checks')
        if check(CACHEONLY):
            flags.append('--no-refresh')
        if check(QUIET):
            flags.append('-q')
        else:
            flags.append('-v')
        if chstr(INSTALLROOT):
            flags.extend(('--installroot', INSTALLROOT))
#        flags = [dnf, 'install', '--use-host-config', '--setopt', 'install_weak_deps='+str(check(RECOMMENDS))]
        if chstr(CACHEDIR):
            flags.extend(('--cache-dir', CACHEDIR))
#        if chstr(LIBDIR):
#            flags.extend(('--setopt','persistdir='+LIBDIR))
        flags.append('install')
        if not INTERACTIVE:
            flags.extend(('--no-confirm',
            '--allow-downgrade',
            '--allow-name-change',
            '--allow-arch-change',
            '--allow-vendor-change',
            '--auto-agree-with-licenses'))
        if check(NOGPGCHECK):
            flags.append('--allow-unsigned-rpm')
   #     if check(DEBUGONLY):
   #         flags.append('--dry-run')
        if check(RECOMMENDS):
            flags.append('--recommends')
        else:
            flags.append('--no-recommends')
        flags.append('--download')
        if check(DOWNLOADONLY):
            flags.append('only')
        else:
            flags.append('in-advance')
        if check(FORCE):
            flags.extend(('--force', '--force-resolution'))
        return flags

def DNF_CONFIG():
        INSTALLROOT=env('INSTALLROOT')
        INTERACTIVE=env('INTERACTIVE')
        QUIET=env('QUIET')
        NOGPGCHECK=env('NOGPGCHECK')
        RECOMMENDS=env('RECOMMENDS')
        DOCS=env('DOCS')
        DOWNLOADONLY=env('DOWNLOADONLY')
        CACHEDIR=env('CACHEDIR')
        LIBDIR=env('LIBDIR')
        RELEASEVER=env('RELEASEVER')
        CACHEONLY=env('CACHEONLY')
        DEBUGONLY=env('DEBUGONLY')
        flags = ['dnf5', 'install', '--use-host-config',
          '--setopt', 'install_weak_deps='+str(check(RECOMMENDS))]
        if chstr(CACHEDIR):
            flags.extend(('--setopt','cachedir='+CACHEDIR))
        if chstr(LIBDIR):
            flags.extend(('--setopt','persistdir='+LIBDIR))
        if check(QUIET):
            flags.append('-q')
        if check(DOWNLOADONLY):
            flags.append('--downloadonly')
        if not check(INTERACTIVE):
            flags.append('-y')
        if not check(DOCS):
            flags.append('--nodocs')
        if check(NOGPGCHECK):
            flags.append('--nogpgcheck')
        if chstr(INSTALLROOT):
            flags.extend(('--installroot', INSTALLROOT))
        if check(CACHEONLY):
            flags.append('--cacheonly')
        if not chstr(RELEASEVER):
            result = subprocess.run(('dnf5', 'config-manager',
                '--dump-variables'), stdout=subprocess.PIPE)
            j = relver.findall(result.stdout.decode('utf-8'))
            if (len(j)>0): j = relatr.findall(j[0])
            if (len(j)>0): RELEASEVER = j[0]

        if chstr(RELEASEVER):
            flags.extend(('--releasever', RELEASEVER))
        return flags

#dnf = ZYPPER_CONFIG
configs = {
    'dnf5': DNF_CONFIG,
    'zypper': ZYPPER_CONFIG
}

from shutil import which

dnf = lambda pkgs, *a: print(pkgs)
key = env("PACKAGEMANAGER")

if not key:
    for key, value in configs.items():
        if which(key):
            dnf = value
            pkgs = [key]
            break
else:
    pkgs = [key]
    dnf = configs.get(key)

pkgs.append('bash')

def load(*a):
    pkgs.sort()
    if check(env('SHOWONLY')):
        for i in pkgs:
            print(i)
    else:
        flags = dnf()
        flags.extend(a)
        flags.extend(pkgs)
        spawn = env('SPAWN')
        if chstr(spawn):
            flags = ['systemd-nspawn', '-D', spawn, *flags]
        print (flags)
        if not check(env('DEBUGONLY')): subprocess.run(flags)

def main():
    load(*sys.argv[1:])

if __name__ == '__main__':
    main()

#our @pkgs;
#use Data::Dumper;
#$Data::Dumper::Terse=1;
#$Data::Dumper::Indent=0;

#our @pkgs;

#our $dnf='dnf';

#push @pkgs, $dnf, 'bash';

#our sub load {
  #my $SHOWONLY=$ENV{'SHOWONLY'};
  #@pkgs=sort @pkgs;
  #if ($SHOWONLY) {
     #for my $pkg (@pkgs){
         #print("$pkg\n");
     #}
     #goto lab;
  #}
  #my $INSTALLROOT=$ENV{'INSTALLROOT'};
  #my $INTERACTIVE=$ENV{'INTERACTIVE'};
  #my $QUIET=$ENV{'QUIET'};
  #my $RECOMMENDS=$ENV{'RECOMMENDS'};
  #my $DOCS=$ENV{'INCLUDEDOCS'};
 ## my $FORCE=$ENV{'FORCE'};
  #my $DOWNLOADONLY=$ENV{'DOWNLOADONLY'};
  #my $CACHEDIR=$ENV{'CACHEDIR'};
  #my $LIBDIR=$ENV{'LIBDIR'};
  #my $RELEASEVER=$ENV{'RELEASEVER'};
  #my $CACHEONLY=$ENV{'CACHEONLY'};

  #my @flags=($dnf, 'install');

  #push @flags, "--setopt=install_weak_deps=@{[$RECOMMENDS ? 'True': 'False']}";
  #$CACHEDIR && push @flags, "--setopt=cachedir=$CACHEDIR";
  #$LIBDIR && push @flags, "--setopt=persistdir=$LIBDIR";
  #$QUIET && push @flags, qw(-q );
  #$DOWNLOADONLY && push @flags, qw(--downloadonly);
  #$INTERACTIVE || push @flags, qw(-y);
  #$DOCS || push @flags, qw(--nodocs);
  #$INSTALLROOT && push @flags, qw(--installroot ), $INSTALLROOT;
  #$CACHEONLY && push @flags, qw(--cacheonly);

  #unless ($RELEASEVER){
    #$RELEASEVER = qx(dnf config-manager --dump-variables);
    #$RELEASEVER =~ m/^(.*releasever.*)$/m;
    #$1 =~ m/.*=\s*(.*)/m;
    #$RELEASEVER =  $1;
  #}

  #print "$RELEASEVER\n";
  #push @flags, "--releasever=$RELEASEVER", @_, @pkgs;

  #print Dumper(\@flags);
  #system(@flags);
  #lab:
#}

#unless (caller){
  #load @ARGV;
#}
