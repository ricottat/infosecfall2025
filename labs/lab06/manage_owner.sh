#!/bin/bash

FILE_PATH="/home/infosecfall2025/labs/lab02/count_word.sh"
sudo touch output.txt

{
echo "Initial ownership:"
ls -l "$FILE_PATH"
echo
} > output.txt

sudo groupadd lab06_group
sudo useradd -m -g lab06_group lab06_user
sudo chown lab06_user:lab06_group "$FILE_PATH"

{
echo "Final ownership:"
ls -l "$FILE_PATH"
echo
} >> output.txt

pkill -KILL -u lab06_user
sudo userdel -r lab06_user
sudo groupdel lab06_group
