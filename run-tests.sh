#!/usr/bin/env bash

if [[ ! -f ./bf ]]; then
    printf "Compiling...\n\n"
    make
    sleep 1
fi


for i in tests/*; do
    printf "\n\nRunning test $i\n\n"
    sleep 1
    timeout 3s ./bf $i
done

printf "\n\nAll tests passed!\n\n"