#!/usr/bin/perl -w

use strict;

my $radio_name = shift @ARGV or die "Need the radio name as argument";
my $id = 1;

while (<>) {
  chomp;
  my $time = time * 1000;
  my $command = "curl -s -XPUT http://ec2-54-209-134-58.compute-1.amazonaws.com:9200/radios/radios/$id -d '{ \"date\": $time, \"name\": \"$radio_name\", \"data\": \"$_\" }'";
 `$command`;
  $id++;
}
