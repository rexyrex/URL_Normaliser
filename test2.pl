#!/usr/bin/perl
# Author: <fill in your name>
# Perl script containing COMP284 Perl exercises.
$log1 = "Generating an unsorted array took 1.259 seconds\n";
$log1 .= "Sorting took 10.486 seconds\n";
$log1 .= " Generating an unsorted array took 1.346 seconds\n";
$log1 .= " Sorting took 9.276 seconds\n";
print $log1;

$_ = $log1;
(/Sorting took (\d+\.\d+) seconds/) && do {
$runtime += $1;
$count++;
print "1: Match found: $1 -- $runtime -- $count\n";
};
print "\n";

$runtime = $count = 0;
$_ = $log1;
while (/Sorting took (\d+\.\d+) seconds/g && $i++ < 10) {
$runtime += $1;
$count++;
print "2: Match found: $1 -- $runtime -- $count\n";
};
print "\n";

$average = $runtime / $count;
print "average is $average";
print "\n";

$count = 0;
$_ = $log1;
while (/(Generating.*Sorting)/sgm) {
$count++;
print "3: Match $count found at $-[0] to ",$+[0]-1,"\n";
}
print "Total number of matches found: $count\n\n";

@urls = (
"http://www.example.com/",
"http://www80.local.com:80/",
"ftp://www.example.com/here/to/information.html",
"HTTP://www.example.com/some/more/information.html#item",
"HTTP://www.example.com/some/../info.html#item",
"https://www.example.com:80/here/there/../search?query",
3"https://www.example.com/some/more/perl?query+me+this",
"https://www.ex221.ac.uk:442/perl/rulez?all+q#all.time");
foreach (@urls) {
print "URL: $_\n";
($scheme,$domain,$port,$path,$query,$fragment) =
(/(.)(.)(.)(.)(.)(.)/);
print "SCHEME: $scheme, DOMAIN: $domain, PORT: $port\n";
print "PATH: $path\n"; print "QUERY: $query\n";
print "FRAGMENT: $fragment\n\n";
}


