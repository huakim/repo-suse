#!/usr/bin/env perl


if (scalar @ARGV){


use File::Spec;
use File::Basename;
use File::Path qw/make_path/;
use Cwd qw(cwd abs_path);
use DB_File;
use Fcntl qw(O_CREAT O_RDWR);
no warnings 'deprecated';

#use CPAN::FindDependencies;

my $dir = (File::Spec->canonpath(File::Spec->catdir(
    dirname(abs_path(__FILE__)), qw(var lib dnf local perl))));
    
make_path ($dir);
chdir ($dir);
    
my %keys;

for (@ARGV){
    
    print "finding dependencies for $_\n";
    my @dependencies = CPAN::FindDependencies::finddeps($_,
        perl => $] );
    foreach my $dep (@dependencies) {
        my $ver = $dep->version();
        my $name = $dep->name();
        $keys{"$name"} = "$ver";
    }
    my $count = scalar @dependencies;
    print "found $count dependencies: \n";
    print join(", \n", map { 
        $_->name() . ' ' . $_->version() . ' ' . $_->distribution()
         } @dependencies );
    print "\n\n";
}
    
$ENV{'HOME'} = cwd();
    
my %array;

tie %array, 'DB_File', 'db_crt', O_RDWR|O_CREAT, 0666, $DB_HASH ;

$array{'File::Find::Rule'}='0.28';
$array{'Unicode::GCString'}='0'; 

while (my ($module, $version) = each(%keys)){
    untie %array;
    tie %array, 'DB_File', 'db_crt', O_RDWR|O_CREAT, 0666, $DB_HASH ;
    
    my $ver = $array{$module};
    print "CURRENT VERSION OF $module IS $version\n";
    if (! defined $ver){
        print "LAST VERSION OF $module IS UNDEFINED\n";
        goto lop2;
    }
    print "LAST VERSION OF $module IS $ver\n";
    if ($ver ne $version){
        lop2:
        print ("BUILDING: $module\n" );
        my $status = system (qw(cpanspec --verbose --force --build 
                --packager rpm  -o), $module);
        print ("CURRENT STATUS: $status\n");
        if ($status == 0){
            $array{$module} = $version;
        }
    } else {
        print ("IS BUILDED: $module\n" );
    }
}
untie %array;
}
