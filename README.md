# certcheck
__*Why use certcheck?*__

certcheck is a simple script that uses the tools already available on a system to generate a report that can be used to track the expiration date of critical website certificates.  This will ensure a level of visibility required to maintain certificate renewals in a timely fashion.

certcheck requires Curl, Perl, and the DateTime module.  

__*Recommended configuration*__

Run certcheck on a Linux host that has the required tools.  Recommend running the report daily using cron and emailing to the webmaster, or using a log aggregator like elastic stack to monitor and send alerts if the expiration date is closing in.
