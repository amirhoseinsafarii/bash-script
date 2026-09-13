#!/bin/bash


for file in front.csv software.csv;do
    tmp=$(mktemp)
    awk -F',' '
    {
        if (!($1 in best) || $2 < best[$1]) {
            best[$1] = $2
        }
    }
    END {
        for (name in best) {
            print name "," best[name]
        }
    }
    ' "${file}" | sort -t',' -k2,2n > "$tmp"
    mv "$tmp" "$file"
done


common=$(mktemp)
awk -F',' '
FILENAME == ARGV[1] {
    names[$1] = 1
    next
}

    $1 in names {
        print $1
    }


' front.csv software.csv > "${common}"

tmp=$(mktemp)

awk -F',' '
FILENAME == ARGV[1] {
    common[$1] = 1
    next
}

{
    if ($1 in common)
        print $1 "*" "," $2
    else
        print $0
}

' "$common" front.csv > "${tmp}"
mv "${tmp}" 'front.csv'




tmp=$(mktemp)

awk -F',' '
FILENAME == ARGV[1] {
    common[$1] = 1
    next
}

{
    if ($1 in common)
        print $1 "*" "," $2
    else
        print $0
}
' "$common" software.csv > "${tmp}"

mv "$tmp" 'software.csv'
