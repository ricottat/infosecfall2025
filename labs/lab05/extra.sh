#!/bin/bash

log="log.txt"

user1="user1_lab05"
user2="user2_lab05"
group="group_lab05"
folder="shared_folder"

sudo useradd -m $user1
sudo useradd -m $user2
sudo passwd $user1
sudo passwd $user2

sudo groupadd $group
sudo usermod -aG $group $user2

sudo mkdir -p "$folder"
sudo touch "$folder/file.txt"

sudo chown $user1:$user1 "$folder"
sudo chown $user2:$user2 "$folder/file.txt"

sudo chmod 750 "$folder"
sudo chmod 640 "$folder/file.txt"

echo "Folder and file ownership and permissions before:" > $log
ls -ld "$folder" >> $log
ls -l "$folder" >> $log

sudo chown $user1:$group "$folder"
sudo chown $user1:$group "$folder/file.txt"

sudo chmod 770 "$folder"
sudo chmod 660 "$folder/file.txt"

echo "Folder and file ownership and permissions after:" >> $log
ls -ld "$folder" >> $log
ls -l "$folder" >> $log

