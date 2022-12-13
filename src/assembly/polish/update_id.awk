#!/usr/bin/awk -f

{
    if ( $1 ~ /^>/ ) {
        split($0, a, "_pilon");
        print a[1];
    } else {
        print $0
    }
}