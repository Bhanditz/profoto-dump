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

PXVIEW="`pwd`/pxview.elf"


BASEDIR="`pwd`"

#
for dbdir in "$1/Profoto/" "$1"/Profoto/*/ ;
	do
	#
	echo "$dbdir"
	# create a directory
	cd "$BASEDIR"
	mkdir -p "`basename "$dbdir"`"
	# dump the database
	$PXVIEW \
		"$dbdir/profoto.db" \
		-b "$dbdir/profoto.MB" \
		-p img \
		--blobextension=bmp \
		-x \
		-o index.htm
	#
done

cd "$BASEDIR"
mv Profoto profoto-dump

#
echo DONE
#
