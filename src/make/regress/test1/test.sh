#!/bin/sh

if [ "$2" = "" ]; then 
    echo usage: $0 prgname errorfile
    exit
fi

LOGFILE=$2

echo \# ===========================
echo \# Multiple Dependents Test
echo \# ===========================

TEST=1
cc -o create create.c
./create 30
rm -f err1.out
touch err1.out
$1 -h -f maketst1 -l err1.out > tst1.out
diff -b tst1.out tst1u.chk
diff -b err1.out err1.chk

if [ "$?" = "0" ]; then
    echo \# Test $TEST successful
else
    echo \#\# INLINE \#\# >> $LOGFILE
    echo Error: Test $TEST unsuccessful!!! | tee -a $LOGFILE
    exit
fi

rm *.obj
rm create
rm *.out
rm main.*
rm foo*.c
rm maketst1
