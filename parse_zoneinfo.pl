#!/usr/bin/perl -w

# Construct cityinfo.h from zone.tag
# (c)2005-2012 Kevin Boone

use strict;

open IN,"</usr/share/zoneinfo/zone.tab" or die "Can't write zone.tab";
open OUT,">cityinfo.h" or die "Can't write cityinfo.h";
print OUT "//Do not edit this file by hand\n";
print OUT "City cities[] = {\n";

while (my $line=<IN>)
  {
  chomp ($line);
  if ($line =~ /^#/) { next; }
#print ("line=$line\n");
  $line =~ /([A-Z][A-Z])\s+([0-9+-]+)\s+([a-zA-Z\/_]+)/;
  my $country = $1;
  my $latlong= $2;
  my $name= $3;
  print ("country = $country\n");
  print ("latlong = $latlong\n");
  print ("name = $name\n");
  $latlong =~ /([+-])([0-9]+)([+-])([0-9]+)/;
  my $lat_sign = $1;
  my $lat = $2;
  my $long_sign = $3;
  my $long = $4;
  print ("lat_sign= $lat_sign\n");
  print ("lat= $lat\n");
  print ("long_sign= $long_sign\n");
  print ("long= $long\n");
  $lat =~ /([0-9][0-9])([0-9][0-9])/;
  my $lat_deg = $1;
  my $lat_min = $2;
  print ("lat_deg= $lat_deg\n");
  print ("lat_min= $lat_min\n");
  $long =~ /([0-9][0-9][0-9])([0-9][0-9])/;
  my $long_deg = $1;
  my $long_min = $2;
  print OUT "{\n";
  print OUT "\"$name\",";
  print OUT "\"$country\",";
  $lat_deg =~ s/^0//;
  $lat_min =~ s/^0//;
  $long_deg =~ s/^0//;
  $long_deg =~ s/^0//;
  $long_min =~ s/^0//;
  print OUT "$lat_deg,$lat_min,"; 
  if ($lat_sign eq "-") { print OUT  "TRUE," } else { print OUT "FALSE," };
  print OUT "$long_deg,$long_min,"; 
  if ($long_sign eq "-") { print OUT  "TRUE" } else { print OUT "FALSE" };
  print OUT "},\n";
  }

print OUT "{NULL, NULL, 0, 0, FALSE, 0, 0, FALSE}";
print OUT "};\n";

