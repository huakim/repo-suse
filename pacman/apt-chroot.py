#!/bin/python3
import os
import re
import subprocess
import sys
relver=re.compile('^(.*releasever.*)$', re.MULTILINE)
relatr=re.compile('.*=\s*(.*)')

env=os.environ.get
dnf='zypper'
pkgs=[dnf, 'bash']

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

def load(*a):
    pkgs.sort()
    if check(env('SHOWONLY')):
        for i in pkgs:
            print(i)
    else:
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
        command = [dnf]
        flags = ['install']

        if check(RECOMMENDS):
            flags.append('--recommends')
        else:
            flags.append('--no-recommends')
        if chstr(CACHEDIR):
            command.extend(('--cache-dir', CACHEDIR))
  #      if chstr(LIBDIR):
  #          flags.extend(('--setopt','persistdir='+LIBDIR))
        if check(QUIET):
            command.append('-q')
        if check(DOWNLOADONLY):
            flags.append('--download-only')
        if not check(INTERACTIVE):
            flags.append('-y')
            command.append('--gpg-auto-import-keys')
#        if not check(DOCS):
 #           flags.append('--nodocs')
        if check(NOGPGCHECK):
            flags.append('--no-gpg-checks')
        if check(INSTALLROOT):
            command.extend(('--installroot', INSTALLROOT))
 #       if check(CACHEONLY):
 #           flags.append('--cacheonly')
  #      if not chstr(RELEASEVER):
  #          result = subprocess.run((dnf, 'config-manager',
  #              '--dump-variables'), stdout=subprocess.PIPE)
  #          j = relver.findall(result.stdout.decode('utf-8'))
  #          if (len(j)>0): j = relatr.findall(j[0])
   #         if (len(j)>0): RELEASEVER = j[0]
   #     if chstr(RELEASEVER):
   #         flags.extend(('--releasever', RELEASEVER))
        flags = command + flags
        flags.extend(a)
        flags.extend(pkgs)
        print (flags)
        if not check(DEBUGONLY): subprocess.run(flags)

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
