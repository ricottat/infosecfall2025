#!/bin/bash
read -p "Enter file location:" file_location
read -p "Enter search word:" search_word

grep -o -i "$search_word" "$file_location" | wc -l
