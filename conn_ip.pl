#!/usr/bin/perl -w
use strict;
use warnings;
my %tracking;
while(<>) {
  chomp;
#udp      17 167 src=10.1.17.27 dst=31.32.31.224 sport=65451 dport=55502 src=31.32.31.224 dst=10.1.17.27 sport=55502 dport=65451 [ASSURED] mark=20 use=1
#tcp      6 72 TIME_WAIT src=10.1.5.24 dst=109.192.7.68 sport=54677 dport=31455 src=109.192.7.68 dst=10.1.5.24 sport=31455 dport=54677 [ASSURED] mark=20 use=1
  if (/^(tcp|udp)\s+\d+.*?src=(.*?) /) {
    $tracking{"$2"}++;
  };
};
for my $entry (keys %tracking) {
  print $tracking{$entry},"\t$entry\n";
};
