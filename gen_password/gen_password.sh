#!/bin/bash

l=$1

if [[ $@ < 1 ]]; then
    echo "Missing argument"
    echo "Usage: length of password"
    echo "Using stanard length 32 characters."
    l=32
fi

apg -m $l -M NCL
