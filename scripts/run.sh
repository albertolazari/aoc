#!/bin/bash -e

script_dir=$(dirname "$0")

input_file=input
part=1
UPDATE_PART='part=$([[ -f part-2$($script_dir/lang -e $language) ]] && echo 2 || echo 1)'

print_help() {
    echo 'usage: run [-dh] [-p 1|2] [-l LANGUAGE]'
    echo Shell options:
    echo '  -p  part of the problem to run (1 or 2)'
    echo '  -l  language to use'
    echo "  -d  debug mode, uses the input file 'input.debug'"
    echo '  -h  print this message'
}

load_options() {
    part_set=0

    while getopts :dhl:p: flag
    do
        case "${flag}" in
            d) input_file='input.debug';;
            l) language=$OPTARG; [[ $part_set == 0 ]] && eval $UPDATE_PART || true;;
            p) part=$OPTARG; part_set=1;;
            h) print_help; exit 0;;
            *) print_help; exit 1;;
        esac
    done
}

# Checks wether a solution script actually exist
if ! compgen -G "part-*.*" > /dev/null; then
    echo Error: no solution found to run
    exit 1
fi

# Retrieves the current selected language
language=$($script_dir/lang)

[[ $(bc -e "$(echo "$language" | wc -l) > 1") == 1 ]] && [[ $(echo "$language" | grep default) ]] && language=$(echo "$language" | grep default | sed -e 's/ (default)//')

[[ $(bc -e "$(echo "$language" | wc -l) > 1") == 0 ]] && eval $UPDATE_PART

load_options "$@"

if [[ $(bc -e "$(echo "$language" | wc -l) > 1") == 1 ]]; then
    echo Error: multiple languages detected
    echo ''
    echo Run your solution with \'run -l LANGUAGE\'
    echo Or set a default language for this day with \'lang -s LANGUAGE\'

    exit 1
fi

# Runs the solution in the selected language and copies the result on the system clipboard
# ready to be pasted on adventofcode.com
if [[ -f $script_dir/run-language/$language ]]
then
    # Running the script, passing as arguments the part to run and the input file, in case
    # some it is preferred to directly read the file for some languages
    $script_dir/run-language/$language $part $input_file < $input_file | pbcopy
else
    echo Error: the selected language has not yet been configured
    exit 1
fi

# Outputs the result, for debugging purposes
pbpaste
