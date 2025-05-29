#!/bin/bash

while read -r line
do
    echo $line
done <<< ./colors/colors.sh
