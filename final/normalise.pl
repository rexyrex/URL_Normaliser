#!/usr/bin/perl

use CGI qw(:all);

print header, "\n",
    start_html({-title=>'Comp284 Assignment 1',
        -author=>'Minhyung Kim'}), "\n";

#User clicks on submit button
if (param('submit')) {
    
	#Initialise value of $url as user input
    $url = param('URL');
    #Check correct URL syntax    
    if($url =~ /((ht|f)?tp(s?)\:\/\/)?([^\/]+\.[^\/]+\.[^\/]+)(\/.*)?/gi){
	
		#Apply Normalisation rules.
        &lower;
        &removeDupSlash;
        &removeDefDir;
        &removeDefPort;
        &removeDotSeg;
		
		#Print out converted URL 
        print h1("Converted URL:"), "\n";
        print "$url", "\n";
    } else {
		#Display error message if URL is invalid
        print "Please enter a valid URL";
    }

}

print h2("URL Converter"), "\n";

#GET request method : Form data appended to URI
print start_form({-method=>"GET",
    -action=>"http://cgi.csc.liv.ac.uk/".
        "cgi-bin/cgiwrap/u3mk/normalise.pl"});

#Text field available for entering the URL
print "URL: ";
print textfield({-name=>'URL',
    -value=>'Enter URL here'}), "\n";
print br(), "\n";

#Submit button (to be pressed for URL conversion)
print submit({-name=>'submit',
    -value=>'Click for response'}), "\n";
print end_form, end_html;

#Makes the host and schema lower case
sub lower {
    $url =~ s/((ht|f)tp(s?)\:\/\/)?([^\/]+\/)?(.+)?/\L$1$4\E$5/gi;    
}

#Remove Duplicate Slashes
sub removeDupSlash {
    $url =~ s/([^((ht|f)tp(s?)\:\/\/)])\/\//$1\//g;
}

#Remove default directories 
sub removeDefDir {
    if($url =~ /((ht|f)tp(s?)\:\/\/)?([^\/]+\/)(default\.asp|index\.html|index\.htm|index\.php|index\.shtml)/gi) {
        $url =~ s/((ht|f)tp(s?)\:\/\/)([^\/]+\/)(default\.asp|index\.html|index\.htm|index\.php|index\.shtml)/$1$4/gi;
    }
}

#remove default Ports (80 for http and 443 for https)
sub removeDefPort {
    if($url =~ m/^http\:\/\// && $url =~ m/\:80/){
    $url =~ s/\:80//;
    }
 
    if($url =~ m/^https\:\/\// && $url =~ m/\:443/){
    $url =~ s/\:443//;
    }
}

#Remove Dot Segments
sub removeDotSeg{
    $inputBuffer = $url;
    $inputBuffer =~ s/((ht|f)tp(s?)\:\/\/)?([^\/]+)?(\/.+)?/$5/gi;
    $outputBuffer = '';
    do{

        #2A "../" -> remove
        if($inputBuffer =~ /^\.\.\//){
            $inputBuffer =~ s/^\.\.\///;

        #2A "./" -> remove
        } elsif($inputBuffer =~ /^\.\// ){
            $inputBuffer =~ s/^\.\///;

        #2C "/../" -> remove from inputbuffer, take last segment off from output buffer
        } elsif($inputBuffer =~ /^\/\.\.\//){
            $inputBuffer =~ s/^\/\.\.\//\//;
            $outputBuffer =~ s/(.+)*(\/.+?)$/$1/;
        #2C "/.." -> remove from inputbuffer, take last segment off from output buffer
        } elsif($inputBuffer =~ /^\/\.\./){
            $inputBuffer =~ s/^\/\.\./\//;
            $outputBuffer =~ s/(.+)*(\/.+)$/$1/;

        #2B "/./" -> replace with "/"
        } elsif($inputBuffer =~ /^\/\.\//){
            $inputBuffer =~ s/^\/\.\//\//;

        #2B "/." -> replace with "/"
        } elsif($inputBuffer =~ /^\/\./){
            $inputBuffer =~ s/^\/\./\//;


        #2D "." or ".." -> remove
        } elsif($inputBuffer eq '.' || $inputBuffer eq '..'){
            $inputBuffer = '';

        #2E No dot segments -> move first segment from input buffer to output buffer
        } else {
            
            if($inputBuffer =~ /^\/.+\/.+/){
                $temp = $inputBuffer;
                $inputBuffer =~ s/^(\/.+?)(\/.+)/$2/;
                $temp =~ s/^(\/.+?)\/(.+)/$1/;
            } else {
                $temp = $inputBuffer;
                $inputBuffer = '';
                $temp =~ s/^(\/.+)/$1/;
            }     
			$outputBuffer = $outputBuffer . $temp;

        }       
	#Loop while input buffer is not empty
    }while($inputBuffer ne '');
	
	#concatenate output buffer (the new path) to URL.
    $url =~ s/((ht|f)tp(s?)\:\/\/)?([^\/]+)?(\/.+)?/$1$4/gi;
    
    $url = $url . $outputBuffer;
    $url =~ s/\/$//;

}


