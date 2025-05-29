#!/bin/bash

source_dir="/home/ec2-user/app.log"

File_Source=$(find . $source_dir -name ".log" -mtime +14)
echo "Files to be deleted: $File_Source"

while read -r file
do
    echo "Delete file: $file"
    rm -rf $file

done <<< $File_SOurce