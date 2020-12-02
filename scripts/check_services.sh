#!/bin/bash

echo "Check cloud services for Dev"

aws_client_present=`aws --version | grep -v 'command not found'`
if [[ $aws_client_present -ge 1 ]]
then 
	echo "AWS present"	
else
	echo "AWS not present"
fi

aws_client_version_full=`aws --version | cut -d '/' -f2`
aws_client_version_number=`aws --version | cut -d '/' -f2 | cut -c 1`

echo 'awc CLI version='$aws_client_version_full

if [[ $aws_client_version_number -eq 2 ]]
then 
	echo 'aws Version is the most recent'
else
	echo 'aws Version is the not most recent'
fi
