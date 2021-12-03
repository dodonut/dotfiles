#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

read -r aaa
if [1==1]
if [ "$aaa" -eq 1 ]; then
    echo a
fi


for i in $aaa; do
    echo "$i"
done

