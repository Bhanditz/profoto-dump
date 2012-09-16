#!/bin/sh

# warnings on
set -e

# to know what the script is doing
set -x

# settings of this script

PXVIEW_VERSION=0.2.5

# verify command line arguments
if [ -z "$1"  -o  "$2"  ] ;
	then
	echo "Usage: $0 location_of_profoto_cd"
	echo "exiting"
	exit 1
fi

# dump the database
"./work/pxview-$PXVIEW_VERSION/src/pxview \
	$1/profoto/Profoto/profoto.db \
	-b $1/profoto/Profoto/profoto.MB \
	-p img \
	--blobextension=bmp \
	-x \
	-o index.htm"

# TODO
echo TODO
