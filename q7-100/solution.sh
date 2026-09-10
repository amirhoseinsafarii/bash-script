#!/bin/bash

groupadd quera-bootcamp

useradd -m -G quera-bootcamp user1
useradd -m -G quera-bootcamp user2

mkdir /bootcamp

touch /bootcamp/bootcamp_data

chown user1:quera-bootcamp /bootcamp
chown user1:quera-bootcamp /bootcamp/bootcamp_data

chmod 660 /bootcamp/bootcamp_data

userdel -r user1
userdel -r user2

groupdel quera-bootcamp

rm /bootcamp/bootcamp_data
rmdir /bootcamp