#!/bin/bash

groupadd shared


useradd -m -G shared user1
useradd -m -G shared user2

passwd -d user1
passwd -d user2

mkdir /shared_files
touch /shared_files/shared_file

chown user1:shared /shared_files
chown user1:shared /shared_files/shared_file

chmod 770 /shared_files
chmod 660 /shared_files/shared_file

userdel -r user1
userdel -r user2

groupdel shared

rm /shared_files/shared_file
rmdir /shared_files