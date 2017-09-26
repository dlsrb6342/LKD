#!/bin/bash
if test -f result.csv; then
    rm result.csv
fi

options=( "create" "destroy" "popup" "move" "resize" "circulate" )
echo "OPTIONS,TASK_CLOCK,CONTEXT_SWITCHES,PAGE_FAULT,TIME" >> result.csv

for i in "${options[@]}"
do
    sudo perf stat x11perf -$i 2> tmp.txt
    TC=$(cat tmp.txt | grep task-clock | awk '{ print $1 }' | sed "s/,//")
    CS=$(cat tmp.txt | grep context-switches | awk '{ print $1 }' | sed "s/,//")
    PF=$(cat tmp.txt | grep page-fault | awk '{ print $1 }' | sed "s/,//")
    TIME=$(cat tmp.txt | grep seconds | awk '{ print $1 }' | sed "s/,//")
    echo $i,$TC,$CS,$PF,$TIME >> result.csv
done

