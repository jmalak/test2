#!/bin/sh

print_header() {
    echo \# -----------------------------
    echo \#   Test $TEST
    echo \# -----------------------------
}

do_check() {
    if [ "$?" = "0" ]; then
        echo \# Test $TEST successful
    else
        echo \#\# PREPROCESS \#\# >> $LOGFILE
        echo Error: Test $TEST unsuccessful!!! | tee -a $LOGFILE
        test
    fi
}

if [ "$2" = "" ]; then 
    echo usage: $0 prgname errorfile
    exit
fi

echo \# ===========================
echo \# Start Preprocessor Test
echo \# ===========================

TEST=1
print_header
$1 -h -f prep01 > tmp.out 2>&1
diff -b prep01.cmp tmp.out
do_check

TEST=2
print_header
$1 -h -f prep02 -m -ms > tmp.out 2>&1
diff prep02.cmp tmp.out
do_check
$1 -h -f prep02 -m     > tmp.out 2>&1
diff prep02.cmp tmp.out
do_check

TEST=3
print_header
$1 -h -f prep03 > tmp.out 2>&1
diff -b prep03.cmp tmp.out
do_check

TEST=4
print_header
$1 -h -f prep04 > tmp.out 2>&1
diff -b prep04.cmp tmp.out
do_check

rm -f tmp.out
