#!/bin/bash

env="xwindow"
options=( "create" "destroy" "popup" "move" "resize" "circulate" )

for i in "${options[@]}"
do
    if test -f /home/jaha/$env/$i.csv; then
        sudo rm $i.csv
    fi
    if test -f /home/jaha/$env/$i.txt; then
        sudo rm $i.txt
    fi
    sudo perf record x11perf -$i
    sudo perf report -t , > /home/jaha/$env/$i.txt
    sudo cp perf.data /home/jaha/$env/$i.data
    CC=$(head -7 /home/jaha/$env/$i.txt | tail -1 | awk '{ print $5 }')
    FIRST=$(head -10 /home/jaha/$env/$i.txt | tail -1)
    SECOND=$(head -11 /home/jaha/$env/$i.txt | tail -1)
    THIRD=$(head -12 /home/jaha/$env/$i.txt | tail -1)
    FOURTH=$(head -13 /home/jaha/$env/$i.txt | tail -1)
    FIFTH=$(head -14 /home/jaha/$env/$i.txt | tail -1)
    
    echo 'CPU CLOCK ' $CC >> /home/jaha/$env/$i.csv 
    echo "Overhead,Command,Shared Object,Symbol" >> /home/jaha/$env/$i.csv
    echo $FIRST >> /home/jaha/$env/$i.csv
    echo $SECOND >> /home/jaha/$env/$i.csv
    echo $THIRD >> /home/jaha/$env/$i.csv
    echo $FOURTH >> /home/jaha/$env/$i.csv
    echo $FIFTH >> /home/jaha/$env/$i.csv
done
