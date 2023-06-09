#!/bin/bash -e

script_dir=$(dirname $0)

print_help () {
    echo usage: lang [-s LANGUAGE] [-e LANGUAGE] [-Eh]
    echo Shell options:
    echo '  -e  return the passed language extension'
    echo '  -E  return the current language extension'
    echo '  -h  print this message'
    echo '  -s  set the language for the day'
}

set_language () {
    language=$1

    if [[ -f $script_dir/languages/run-$language ]]
    then
        echo $language > .lang
        exit 0
    else
        echo Error: the selected language has not yet been configured >&2
        exit 1
    fi
}

extension_of () {
    case $1 in
        bash)           echo sh;;
        spreadsheet)    echo xlsx;;
        sql)            echo sql;;
        pascal)         echo pas;;
        r)              echo r;;
        perl)           echo pl;;
        clojure)        echo clj;;
        php)            echo php;;
        rust)           echo rs;;
        javascript)     echo js;;
        ruby)           echo rb;;
        python)         echo py;;
        java)           echo java;;
        c)              echo c;;
        c++)            echo cpp;;
        j)              echo ijs;;
        vimscript)      echo vim;;
        fortran)        echo f;;
    esac
}

language_of () {
    case $1 in
        sh)     echo bash;;
        xlsx)   echo spreadsheet;;
        sql)    echo sql;;
        pas)    echo pascal;;
        r)      echo r;;
        pl)     echo perl;;
        clj)    echo clojure;;
        php)    echo php;;
        rs)     echo rust;;
        js)     echo javascript;;
        rb)     echo ruby;;
        py)     echo python;;
        java)   echo java;;
        c)      echo c;;
        cpp)    echo c++;;
        ijs)    echo j;;
        vim)    echo vimscript;;
        f)      echo fortran;;
    esac
}

load_options() {
    while getopts :e:Ehs: flag
    do
        case "${flag}" in
            e) echo .$(extension_of $OPTARG); exit 0;;
            E) [[ $language != '' ]] && echo .$(extension_of $language); exit 0;;
            s) set_language $OPTARG;;
            h) print_help; exit 0;;
            *) print_help; exit 1;;
        esac
    done
}

language=''

[[ -f .lang ]] && language=$(cat .lang)

languages=''

# Retrieve languages from the file extension
for extension in $(ls -1q part-{1,2}.* 2> /dev/null | sed -E 's/^.*\.(.*)$/\1/' | sort -u)
do
    l=$(language_of $extension)
    if [[ $l != $language ]]
    then
        languages="$languages$l"$'\n'
    else
        languages="$languages$l (default)"$'\n'
    fi
done

languages=$(echo "$languages" | sed -E 's/\n$//')

load_options "$@"

echo "$languages"
