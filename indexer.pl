#!/usr/bin/perl -w

use strict;
use Search::Elasticsearch;

my $e = Search::Elasticsearch->new(
    nodes    => 'ec2-54-209-134-58.compute-1.amazonaws.com:9200'
);

my $radio_name = shift @ARGV or die "Need the radio name as argument";
my $id = 1;

while (<>) {
  chomp;
  s/ +/ /g;
  my $time = time * 1000;
  my $command = "curl -s -XPUT http://ec2-54-209-134-58.compute-1.amazonaws.com:9200/radios/radios/$id -d '{ \"date\": $time, \"name\": \"$radio_name\", \"data\": \"$_\", \"data_raw\": \"$_\" }'";
  $e->index(
    index   => 'radios',
    type    => 'radios',
    id      => $id,
    body    => {
      date => $time,
      name => $radio_name,
      data => $_,
      data_raw => $_
    }
  );

  $id++;
}
