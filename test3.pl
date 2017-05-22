@urls = (
"http://www.example.com/",
"http://www80.local.com:80/",
"ftp://www.example.com/here/to/information.html",
"HTTP://www.example.com/some/more/information.html#item",
"HTTP://www.example.com/some/../info.html#item",
"https://www.example.com:80/here/there/../search?query",
"https://www.example.com/some/more/perl?query+me+this",
"https://www.ex221.ac.uk:442/perl/rulez?all+q#all.time");
foreach (@urls) {
print "URL: $_\n";
($scheme,$domain,$port,$path,$query,$fragment) =
(m!^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?!);
print "SCHEME: $scheme, DOMAIN: $domain, PORT: $port\n";
print "PATH: $path\n"; print "QUERY: $query\n";
print "FRAGMENT: $fragment\n\n";
}
