#!/usr/bin/perl -w

############################
# Creator: Jeff Israel
#
# Script:	./simple-rss-reader-v3.pl
# Version: 	3.001

use LWP::Simple;

############################
# Configs

$rssPage = "https://www.archlinux.org/feeds/news/";
$numLines = 8;
$maxTitleLenght = 60;
$goto = '${goto 700}';

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
	if($line =~ /\<title\>/){ # Is a good line?
		#print "- $line\n";
		$lineCat = $line;
		$lineCat =~ s/.*\<title\>//;
		$lineCat =~ s/\<\/title\>.*//;
		$lineCat =~ s/\[.{4,25}\]$//; # strip no-fun data ( [from blaaa] )
		$lineCat = substr($lineCat, 0, $maxTitleLenght);
		print "$goto$lineCat \n";
		$x++;
	}
	if($x > $numLines) {
		last; #exit on max-lines
	}
}
