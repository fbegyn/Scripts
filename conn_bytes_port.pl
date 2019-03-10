#!/usr/bin/perl -w
use strict;
use warnings;
my %out_packets_per_port;
my %in_packets_per_port;
my %out_bytes_per_port;
my %in_bytes_per_port;
while(<>) {
  chomp;
#tcp      6 46 TIME_WAIT src=10.1.30.223 dst=12.129.236.214 sport=60058 dport=1119 packets=5 bytes=617 src=12.129.236.214 dst=10.1.30.223 sport=1119 dport=60058 packets=5 bytes=479 [ASSURED] mark=20 use=2
  next unless /^(tcp|udp)\s+\d+.*?src=(.*?) dst=(.*?) sport=(\d+) dport=(\d+) packets=(\d+) bytes=(\d+) .* packets=(\d+) bytes=(\d+)/;
  # $1 protocol
  # $2 src-ip
  # $3 dst-ip
  # $4 sport
  # $5 dport
  # $6 outpackets
  # $7 outbytes
  # $8 inpackets
  # $9 inbytes
  $out_packets_per_port{"$1-$5"} += $6;
  $out_bytes_per_port{"$1-$5"} += $7;
  $in_packets_per_port{"$1-$5"} += $8;
  $in_bytes_per_port{"$1-$5"} += $9;
};
printf("%-10s %16s %16s %16s %16s\n", qw(Port OutPkt OutBytes InPkts InBytes));
for my $entry(sort {$out_bytes_per_port{$a} <=> $out_bytes_per_port{$b}} keys %out_bytes_per_port) {
#for my $entry(keys %out_packets_per_port) {
  printf("%-10s %16s %16s %16s %16s\n", $entry, $out_packets_per_port{$entry}, $out_bytes_per_port{$entry}, $in_packets_per_port{$entry}, $in_bytes_per_port{$entry});
};
printf("%-10s %16s %16s %16s %16s\n", qw(Port OutPkt OutBytes InPkts InBytes));
