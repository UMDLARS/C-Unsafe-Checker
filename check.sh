#!/bin/bash

BANNED="strcpy strcat strtok sprintf vsprintf gets strlen"

echo "Checking for banned functions: $BANNED"
for SOURCEFILE in "$@"
do
    echo "Checking '$SOURCEFILE'..."
    for bfunc in $BANNED
    do
        if grep -E "\s${bfunc}\s*\(" $SOURCEFILE &> /dev/null
        then
            echo "BANNED FUNCTION '$bfunc' DETECTED in '$SOURCEFILE' on line:"
            echo
            grep -nE "\s${bfunc}\s*\(" $SOURCEFILE
            echo
            echo "Remove all banned functions from your code and try again."
            exit 1
        else
            echo "    $bfunc"
        fi
    done
done

echo "All is good here."
exit 0
