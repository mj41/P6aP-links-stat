#!/usr/bin/perl

use strict;
use warnings;
#use Data::Dumper;

while ( my $line = <> ) {
    #chomp( $line );
    #print Dumper( $line );
    #print "---$line---\n";
    next if $line !~ m/ \* \s* \'* \s* \[ /x;
    print $line;
}
