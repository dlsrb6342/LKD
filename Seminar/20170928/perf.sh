#!/bin/bash


options=( "create" "destroy" "popup" "move" "resize" "circulate" )
for i in "${options[@]}"
do
    if test -f $i.csv; then
        rm $i.csv
    fi
    echo "Overhead,Command,Shared Object,Symbol" >> $i.csv
    sudo perf record x11perf -$i
    sudo perf report -t , > tmp.txt
    FIRST=$(head -10 tmp.txt | tail -1)
    SECOND=$(head -11 tmp.txt | tail -1)
    THIRD=$(head -12 tmp.txt | tail -1)
    FOURTH=$(head -13 tmp.txt | tail -1)
    FIFTH=$(head -14 tmp.txt | tail -1)
    
    echo $FIRST >> $i.csv
    echo $SECOND >> $i.csv
    echo $THIRD >> $i.csv
    echo $FOURTH >> $i.csv
    echo $FIFTH >> $i.csv
done
