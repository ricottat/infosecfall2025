#!/bin/bash

BASE="/home/infosecfall2025/labs/lab05/users"

sudo mkdir -p "$BASE"

for user in user1 user2 user3; do
	sudo mkdir -p "$BASE/$user"
	sudo useradd -m -d "$BASE/$user" -s /bin/bash "$user"
	sudo chown -R "$user:$user" "$BASE/$user"
done

for group in group1 group2 group3; do
	sudo groupadd "$group"
done

sudo usermod -aG group1,group2,group3 user1
sudo usermod -aG group2,group3 user2
sudo usermod -aG group1 user3

groups user1
groups user2
groups user3
