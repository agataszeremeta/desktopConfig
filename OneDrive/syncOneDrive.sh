#!/bin/bash

# Resync OneDrive files
# mark="'";
if [ $# -gt 0 ]
then
	for direct in "$@"
	do
		# echo $direct; # LiteratureReview/
		# onedrivePath=$mark$direct$mark;
		onedrive --resync --synchronize --single-directory $direct;
	done
else
	# Sync default folders of LiteratureReview and Thesis
	onedrive --resync --synchronize --single-directory 'LiteratureReview/' --single-directory 'Thesis/' --single-directory 'Resume/'

fi
