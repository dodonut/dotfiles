#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

read -r aaa
if [[  $aaa < test ]]; then
    echo a
fi

for i in $aaa; do
    echo "$i"
done

