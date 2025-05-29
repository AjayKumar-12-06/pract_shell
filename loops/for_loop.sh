#!/bin/bash

USER_ID=$(id -u)
if [ $User_Name -ne 0 ]; then
    echo "you must have the sudo access to execute this"
    exit 1
fi

for package in $@
do
    dnf list installed $package
        echo "if $package is not available, now i'm going to installing $package"
            dnf install $package -y
                if [ $? -ne 0 ]; then
                    echo " $package installing failure"
                    exit 1
                else
                    echo "$package installing success"
                fi
done