#!/bin/bash


nmap='nmap'
nmapopt='-v -oN'
date=`date | awk {'print $2 $6 $3'}`
file="$HOME/logs/nmap-${date}.log"
network='10.0.0.0/24'

$nmap $network $nmapopt $file 

