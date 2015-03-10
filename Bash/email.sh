#!/bin/bash

from=''
to=''
subject='test subject'
body='test body'
date=`date | awk {'print $2 $6 $3'}`
attachment="$HOME/logs/nmap-${date}.log"

{

echo "From: $from
To: $to
Subject: $subject
Mime-Version: 1.0"

$body

#[ ! -f "$attachment" ] && echo "Warning: attachment $attachment not found"

} | sendmail -t -oi
