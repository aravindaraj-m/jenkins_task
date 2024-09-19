#!/bin/bash

read -p "Enter the url " url

httpcode=$(curl -s -o /dev/null -I -w "%{http_code}" $url)

if [ $httpcode -eq 200 ]
then 
	echo " Site is reachable and the code is $httpcode"
else
	echo " Site is not reachable and code is $httpcode "
fi
