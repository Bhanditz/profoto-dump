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
./pxview.elf \
	"$1/Profoto/profoto.db" \
	-b "$1/Profoto/profoto.MB" \
	-p img \
	--blobextension=bmp \
	-x \
	-o index.htm

# TODO
echo TODO
