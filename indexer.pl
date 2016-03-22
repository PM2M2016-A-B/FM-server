#!/usr/bin/perl -w

use strict;

my $radio_name = shift @ARGV or die "Need the radio name as argument";
my $id = 1;

while (<>) {
  my $time = time * 1000;
  `curl -XPUT http://localhost:9200/radios/radios/$id -d '{ "date": $time, "name": "$radio_name", "data": "$_", "data_raw": "$_" }'`;
  $id++;
}
