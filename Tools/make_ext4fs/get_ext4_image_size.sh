#!/bin/sh

set -e

IMG_FILE=$1
TMP_OUTPUT=/tmp/fsinfo

tune2fs -l $IMG_FILE > $TMP_OUTPUT

BLOCK_COUNT=`grep 'Block count' $TMP_OUTPUT|awk '{ print $3 }'`
BLOCK_SIZE=`grep 'Block size' $TMP_OUTPUT|awk '{ print $3 }'`

# echo $BLOCK_COUNT
# echo $BLOCK_SIZE

TOTAL_SIZE=`expr $BLOCK_COUNT \* $BLOCK_SIZE / 1024 / 1024`

echo "$TOTAL_SIZE"M
