#!/bin/bash -e

script_dir=$(dirname $0)
DAY_PATTERN='day-'

if [[ ! $(basename $PWD) =~ ^day-[0-9]+$ ]]
then
    echo Error: you need to be in a ${DAY_PATTERN}n/ directory
    exit 1
fi

day=$(basename $PWD | sed "s/^$DAY_PATTERN//")

if [[ ! -f $script_dir/user-session ]]
then
    echo Error: you need to copy your session in tools/user-session
    exit 1
fi

curl https://adventofcode.com/2022/day/$day/input --cookie "session=$(cat $script_dir/user-session)" > input
