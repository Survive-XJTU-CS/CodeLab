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

diff ./diff/diff1.csv ./diff/correct.csv > /dev/null
if [ $? == 0 ]; then
	echo "=========PASSED========== "
	rm -rf diff
else
	echo "Something Wrong~, Please Check the diff dir!"
fi