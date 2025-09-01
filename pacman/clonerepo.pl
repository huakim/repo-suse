#!/usr/bin/env perl
use DPKG::Parse::Packages;
use File::Basename;
use File::Copy::Recursive qw(pathmk);
use File::Spec::Functions qw(catfile);
use Cwd 'abs_path';
use Algorithm::Loops qw(NestedLoops);
use File::Path qw(rmtree);
use Set::Scalar;
use File::Find;

my $pkgs;
local $set=Set::Scalar->new;
local $dirset=Set::Scalar->new;

my $dists=['dists'];
my $releases=['fijik19'];
my $parts=['main'];
my $archs=['binary-all','binary-amd64','binary-i386'];

my $dir = catfile(abs_path(dirname($0)), 
    'var', 'lib', 'apt', 'local');
chdir("$dir");

my $iter = NestedLoops([ $dists, $releases, $parts, $archs ]);

while ( my @loop = $iter->() ) {
    my $path = join('/', @loop, 'Packages');
    if ( -f $path ){
        $pkgs=DPKG::Parse::Packages->new;
        $pkgs->filename($path);
        $pkgs->parse;
        for my $entry (@{$pkgs->entryarray}){
            my $filename = $entry->{filename};
            $dirset->insert(dirname($filename));
            $set->insert($filename);
        }
    }
}

use Data::Dumper;

find({ wanted => sub {
  if (-d $_) {
    $dirset->insert("$_");
  } else {
    $set->insert("$_");      
  }
}, no_chdir => 1 },'dists');

rmtree('repo/debian');

for my $e ($dirset->elements) { 
    pathmk("repo/debian/$e");
}

for my $e ($set->elements) { 
    link($e, "repo/debian/$e");
}
