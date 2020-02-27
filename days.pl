#!/usr/bin/perl -w
############################################################################
# days.pl - calculate the number of days between 2 dates
# Copyright (C) 2020, Ellie McNeill
# Usage: days YYYY-MM-DD [YYYY-MM-DD]
# If only one date is supplied, then the current date will be used as the
# second parameter. 
# This program requires the Date::Calc module. On Debian systems, this is
# provided by the package libdate-calc-perl
############################################################################

use Date::Calc qw(Delta_Days);

if(@ARGV==2){
    unless($ARGV[1] =~ /^\d{1,4}-\d{1,2}-\d{1,2}$/){
        die "$ARGV[1]: Invalid date format. Please use YYYY-MM-DD\n" 
    } # No leading zeroes required as in ISO-8601
    ($year2,$month2,$day2)=split(/-/, $ARGV[1]) 
} elsif(@ARGV==1) {
    ($year2,$month2,$day2)=(localtime)[5,4,3];
    $year2+=1900; # Correct the year provided by localtime
    $month2++; # Correct the month provided by localtime
} else {
     die "Usage: YYYY-MM-DD [YYYY-MM-DD]\n";
}

($year1,$month1,$day1)=split(/-/, $ARGV[0]);
unless($ARGV[0] =~ /^\d{1,4}-\d{1,2}-\d{1,2}$/){
    die "$ARGV[0]: Invalid date format. Please use YYYY-MM-DD\n" 
}

eval { $days=Delta_Days($year1,$month1,$day1,$year2,$month2,$day2) };
die "Error: Illegal date.\n" if $@; # Verify that dates actually exist!
$days=abs($days); # Do not use negative numbers
print "$days\n";
