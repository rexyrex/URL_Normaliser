$name = "Dr Ullrich Hustadt";
$name =~ s/(Mr|Ms|Mrs|Dr)?\s*(\w+)\s+(\w+)/\U$3\E, $2/;
print "$name";
print "\n";
$text = "rofl";
$text =~ s/r//;
print "$text";
print "\n";

$test = "www.google.com";
$test =~ s/(\w+)\.(\w+)\.(\w+)/$1.\U$2\E.$3/;
print "$test";
print "\n";

$url = "HTTp://wwW.GOogle.com/defaUlt.asp";
$url =~ s/((ht|f)tp(s?)\:\/\/)?([^\/]+\/)?(.+)?/\L$1$4\E$5/gi;
print "$url";
print "\n";

$url2 = "http://www.sam.com//rofl/com//ram//dot/z";
$url2 =~ s/[^((ht|f)tp(s?)\:\/\/)]\/\//\//g;
print "$url2";
print "\n";

$url3 = "http://www.example.com/default.asp";
if($url3 =~ /((ht|f)tp(s?)\:\/\/)?([^\/]+\/)(default\.asp|index\.html|index\.htm|index\.php|index\.shtml)/gi) {
	$url3 =~ s/((ht|f)tp(s?)\:\/\/)([^\/]+\/)(default\.asp|index\.html|index\.htm|index\.php|index\.shtml)/$1$4/gi;
}
print "$url3";
print "\n";


$url4 = "https://www.example.com:443/bar.html";

if($url4 =~ m/^http\:\/\// && $url4 =~ m/\:80/){
	$url4 =~ s/\:80//;
}

if($url4 =~ m/^https\:\/\// && $url4 =~ m/\:443/){
	$url4 =~ s/\:443//;
}

print "$url4";
print "\n";

$url5 = "http://www.example.com/../a/b/../c/./d.html";

if( $url5 =~ m/\.\.\// || $url5 =~ m/\.\//){
	$url5 =~ s/\.\.\//;
	$url5 =~ s/\.\//;
}

if($url5 =~ m/\/\.\// || m/\/\./){
	$url5 =~ s/\/\.\//\//;
	$url5 =~ s/\/\./\//;
}


$url5 =~ s/\/\.\.\//\//g;
$url5 =~ s/\/\.\//\//g;

print "$url5";
print "\n";
