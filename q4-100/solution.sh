#!/bin/bash

awk '

    /^!\[.*\]\(.*\)$/ {
        if(length(block) > 200 ){
            black = 1
        }

        block = ""
        next
        
    }


    {
        block = block $0 "\n"

    }

    END {
        if (length(block) > 200) 
            black = 1
        if (black)
            print "YES" 
        else 
            print "NO"
        }


' quera.md