#!/bin/bash

Fruits=["Apple", "Banana","Mango"]

echo "The 1st fruit is :" ${Fruits[0]}
echo "The 2nd fruits is :" ${Fruits[1]}
echo "Printing Number os fruits :" ${#Fruits[@]}
echo "printing all the fruits : " ${Fruits[*]}
