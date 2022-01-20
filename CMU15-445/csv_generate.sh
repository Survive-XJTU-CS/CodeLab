#!/bin/bash

if [ ! -d diff ]; then
	mkdir diff
else
	echo dir exist
fi

sqlite3 northwind-cmudb2021.db <<!
.headers on
.mode csv
.once ./diff/diff1.csv
.read $1 

.once ./diff/correct.csv
.read $2

.quit
!

cd diff
# OSX System
if [ "$(uname)" == "Darwin" ]; then
	gsed -i "1d" *.csv
# GNU/Linux System
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	sed -i "1d" *.csv
fi

#diff diff1.csv correct.csv > /dev/null
#if [ $? == 0 ]; then
#	echo "=========PASSED=========="
#	cd ..
#	rm -rf diff
#else
#	echo "Something Wrong~, Please Check the diff dir!"
#fi