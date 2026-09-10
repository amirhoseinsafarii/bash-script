#!/bin/bash


awk -F ',' '
    NR > 1 {
        gsub(" ", "_", $1 )
        system("mkdir -p Cases/"$2)
        system("touch Cases/"$2"/"$1)
        path = sprintf("Cases/" $2 "/" $1)
        print $4 > path

        if ($3 == "Solved")
            system("chmod u=rw,g=r,o=r Cases/" $2 "/" $1)
        else if ($3 == "Not Started")
            system("chmod u=r,g=-,o=- Cases/" $2 "/" $1)
        else if ($3 == "In Progress")
            system("chmod u=rw,g=r,o=- Cases/" $2 "/" $1)
    }
' cases.csv