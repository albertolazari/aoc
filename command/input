#!/bin/bash -e

script_dir=$(dirname $0)
cookie=$script_dir/../user-session
DAY_PATTERN='day-'

if [[ ! $(basename $PWD) =~ ^day-[0-9]+$ ]]
then
    echo Error: you need to be in a ${DAY_PATTERN}n/ directory
    exit 1
fi

day=$(basename $PWD | sed "s/^$DAY_PATTERN//")

if [[ ! -f $cookie ]]
then
    echo Error: you need to copy your session in tools/user-session
    exit 1
fi

curl -s https://adventofcode.com/2022/day/$day/input --cookie "session=$(< $cookie)" > input
