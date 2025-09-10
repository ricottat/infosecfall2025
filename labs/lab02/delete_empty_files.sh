#!/bin/bash
read -p "Enter directory location:" dir_location

if [ -z "$(ls -A "$dir_location")" ]; then
        echo "Directory is empty"
        exit 1
fi

for file in "$dir_location"/*; do
        if [ -f "$file" ]; then
                if [ ! -s "$file" ] || ! grep -q '[^[:space:]]' "$file"; then
                        echo "$file"
                        sudo rm -f "$file"
                fi
        fi
done
