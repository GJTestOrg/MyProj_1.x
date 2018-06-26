#!/bin/bash

for file in $(find . -type f -regex ".*\.php")
do
  awk '/###DOCBLOCK###/ { system("cat ./DOCBLOCK_php.txt"); next } 1' $file > tmpfile
  sed -i 's/\s*$//' tmpfile
  rm $file
  mv tmpfile $file
done
