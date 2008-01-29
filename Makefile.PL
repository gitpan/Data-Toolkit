#!/usr/bin/perl -w
#
# Makefile.PL
#
# $Id$

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'		=> 'Data::Toolkit',
    'VERSION'		=> 0.4,
    'PREREQ_PM'		=> {	Data::Dumper => 0,
				Carp => 0,
				Clone => 0,
				Data::Dumper => 0,
				Data::MultiValuedHash => 0,
				Net::LDAP::Entry => 0,
				DBD::CSV => 0,
				Text::CSV_XS => 0,
				SQL::Statement => 1.15,
			 },
    'test'		=> {TESTS => 'tests/*.t'},

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT => 'Toolkit for manipulating attribute-value data. Useful in directory synchronisation systems and other data‐pump applications.',
       AUTHOR     => 'Andrew Findlay <andrew.findlay@skills-1st.co.uk>') : ()),
);
