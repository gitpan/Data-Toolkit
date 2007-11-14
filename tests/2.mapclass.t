#!/usr/bin/perl -w
#
# Tests for Data::Toolkit::Map

use strict;

use lib '../lib';

use Carp;
use Test::Simple tests => 15;

use Data::Dumper;
use Data::Toolkit::Entry;
use Data::Toolkit::Map;

my $map = Data::Toolkit::Map->new();
ok (($map and $map->isa( "Data::Toolkit::Map" )), "Create new Data::Toolkit::Map object");

ok (Data::Toolkit::Map->debug() == 0, "Debug level should start at zero");

ok (Data::Toolkit::Map->debug(1) == 1, "Setting debug level to 1");
# my $map2 = Data::Toolkit::Map->new();
# ok (($map2 and $map2->isa( "Data::Toolkit::Map" )), "Create new Data::Toolkit::Map object");
ok (Data::Toolkit::Map->debug(0) == 0, "Setting debug level to 0");

ok ( !defined($map->outputs()->[0]), "No outputs are defined yet");
ok ( ($map->set('sn','surname') eq 'surname'), "Setting an attribute-to-attribute mapping");
my $res = $map->set('cn',['Andrew Findlay','A J Findlay']);
ok ( ((scalar @$res) == 2), "Setting a fixed attribute mapping");
# print "SET: ", (join ",", $map->set('cn',['Andrew Findlay','A J Findlay'])), "\n";
ok ( ((join ",",$map->outputs()) eq 'cn,sn'), "Map has right outputs" );

# print "OUT: " . (join ",",$map->outputs()) . "\n";

sub buildPhone {
	return [ "+44 " . "1234 567890" ];
}

ok ( $map->set('phone', \&buildPhone), "Setting a procedure mapping");

ok ( $map->set('mail', sub { return "test" . '@' . "example.org" }), "Setting a closure mapping");

ok ( !defined($map->generate( 'noSuchAttrib' )), "Generate from undefined attrib returns undefined" );
#print Dumper($map->generate('phone'));
my $tel = $map->generate('phone');
ok (($tel and ($tel->[0] eq '+44 1234 567890')), "procedural mapping with no entry" );

my $entry = Data::Toolkit::Entry->new();
$entry->set('voice',['xyzzy']);


sub retNull {
	return undef;
}
ok ( $map->set('nada', \&retNull), "Setting a procedure to return undef");

ok ( !defined($map->generate( 'nada' )), "Generate from procedure returning undef returns undefined" );

my $currOut = join ':', $map->outputs();
$currOut =~ s/mail://;
$map->unset('mail');
ok (((join ':',$map->outputs()) eq $currOut), "Unset removes a mapping completely");

