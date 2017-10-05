#!/bin/bash

source_file=$1
dest_file=$2

if [ ! ${source_file} ] && [ ! ${dest_file} ]; then
    echo "Usage: command <source_file> <destination_file>"
    exit 1
fi

diff -u ${dest_file} ${source_file}
my_diff_ret=$?

if [ ${my_diff_ret} -ne 0 ]; then
    rsync -av --progress ${source_file} ${dest_file}
fi

