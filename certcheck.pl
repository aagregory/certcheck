#!/usr/bin/perl -w

 

#

#Check key URLS for cert expiration

#

#

 

use DateTime;

 

$monthnum = 0;

$daysleft = 0;

$expiremonth = 0;

$expireday = 0;

$expireyear = 0;

 

open (expire, ">/tmp/expire_report.csv") or die $!;

        print expire "#Days until expire, Expiration Date, URL\n";

close (expire);

 

 

 

open (myurls, "</home/opc/code/certs/urls.txt") or die $!;

    while($urls=<myurls>){

        chomp($urls);

        push(@urls, $urls);

        }

close(myurls);

 

 

 

foreach $url (@urls){

open (myout, "curl -vI \"${url}\" --stderr - |" ) or die $!;

                while ($theout=<myout>){

                   chomp($theout, $url);

                   next unless $theout =~ /expire date/;

                   $theout =~ s/^\*\s{2}expire date\:\s//;

                  

                   @expiremonth = split(" ",$theout);

                   $expiremonth = $expiremonth[0];

                   $expireday = $expiremonth[1];

                   $expireyear = $expiremonth[3];

                   #print "Expiremonth is $expiremonth\n";

                        getmonthnum($expiremonth);

                        calcdays($expireyear,$monthnum,$expireday);

                        open (expire, ">>/tmp/expire_report.csv") or die $!;

                                print "${daysleft},${theout}\,${url}\n";

                                print expire "${daysleft},${theout}\,${url}\n";

                        close(expire);

                        }

close(myout);

    }

 

 

sub getmonthnum{

 

#my $actual = $_;

my @months = (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);

 

$monthnum = 0;

foreach $month (@months){

        $monthnum++;

        if ($month =~ /$expiremonth/i){

                #print "Month number is $monthnum\n";

               return $monthnum;              

        }

}

}

 

 

sub calcdays{

 

my $then = DateTime->new( year => ${expireyear}, month => ${monthnum}, day => ${expireday} );

my $now  = DateTime->now();

 

$daysleft = $now->delta_days($then)->delta_days();

#print "Days left is $daysleft\n";

 

return $daysleft;

 

}

 

exit;
