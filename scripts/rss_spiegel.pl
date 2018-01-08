#!/usr/bin/perl -X

############################
# Creator: Jeff Israel
#
# Script:	./simple-rss-reader-v3.pl
# Version: 	3.001
#
# Changed: A-A-G

use LWP::Simple; #install perl https support
use HTML::Entities; #german
use Encode;

############################
# Configs

$rssPage = "http://www.spiegel.de/schlagzeilen/tops/index.rss";
$numLines = 18;
$maxTitleLenght = 90;
$goto = '${goto 650}';

###########################
# Code

# Downloading RSS feed
my $pageCont = get($rssPage);

# Spliting the page to lines
@pageLines = split(/\n/,$pageCont);

# Parse each line, strip no-fun data, exit on max-lines
$numLines--; #correcting count for loop
$x = 0;
foreach $line (@pageLines) {
	if($line !~ /SPIEGEL ONLINE/){
		if($line =~ /\<title\>/){ # Is a good line?
			#print "- $line\n";
			$lineCat = $line;
			$lineCat =~ s/.*\<title\>//;
			$lineCat =~ s/\<\/title\>.*//;
			$lineCat =~ s/\[.{4,25}\]$//; # strip no-fun data ( [from blaaa] )
			$lineCat = substr($lineCat, 0, $maxTitleLenght);
			$lineCat = decode_entities($lineCat);
			$lineCat = encode('UTF-8', $lineCat);
			print "$goto$lineCat \n";
			$x++;
		}
	}
	if($x > $numLines) {
		last; #exit on max-lines
	}
}
