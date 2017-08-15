#!/bin/bash
if test -f result.csv; then
    rm result.csv
fi

options=( "dot" "rect10" "circle10" )
echo "OPTIONS,TASK_CLOCK,CONTEXT_SWITCHES,CPU_MIGRATIONS,PAGE_FAULT,TIME" >> result.csv

for i in "${options[@]}"
do
    sudo perf stat x11perf -$i 2> tmp.txt
    TC=$(cat tmp.txt | grep task-clock | awk '{ print $1 }' | sed "s/,//")
    CS=$(cat tmp.txt | grep context-switches | awk '{ print $1 }' | sed "s/,//")
    CPU=$(cat tmp.txt | grep cpu-migrations | awk '{ print $1 }' | sed "s/,//")
    PF=$(cat tmp.txt | grep page-fault | awk '{ print $1 }' | sed "s/,//")
    TIME=$(cat tmp.txt | grep seconds | awk '{ print $1 }' | sed "s/,//")
    echo $i,$TC,$CS,$CPU,$PF,$TIME >> result.csv
done
