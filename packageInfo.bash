#!/bin/bash

# packageInfo.bash
# Purpose: Generates a report to include specific package information
#
# Usage: ./packageInfo.bash [package-name]
#
# Author: *** Soheil Salimi ***
# Date: *** 2024-02-08 ***

# Test for sudo
user=$(whoami)
if [ $user != "root" ]
then
	echo "You must run this script with root privileges. Please use sudo" >&2
	exit 1
fi

# Test for argument
if [ $# -ne 1 ] 
then
	echo "Your command must have a package-name as an argument" >&2
	echo "USAGE: $0 [package-name]" >&2
	exit 2
fi

# Create report title
# (echo with -e option allows newline \n character to be used)
reportPath="/home/ssalimi19/bin"
echo -e "SOFTWARE PACKAGE INFORMATION REPORT" > ${reportPath}/package-info.txt
echo -e "Date: $(date +'%A %B %d, %Y (%H:%M:%p)')\n\n " >> ${reportPath}/package-info.txt

# Clear screen and use Here Document to display select on report items to read into variable
clear
cat <<+
Available Package Information Items:

Package
Status
Section
Maintainer
Version
Homepage
+
read -p "Enter word(s) shown above separated by spaces: " choice

# Convert spaces to pipe symbol (|)
processedChoice=$(echo $choice | sed 's/ /|/g')

# Use sed with extended regular expressions to only print those matching report elements
dpkg-query -s $1 | sed -r -n "/^($processedChoice)/ p" >> ${reportPath}/package-info.txt

cat <<+
File "${reportPath}/package-info.txt" has been created
+
