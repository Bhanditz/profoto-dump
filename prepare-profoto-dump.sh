#!/bin/sh

# warnings on
set -e

# to know what the script is doing
set -x

# settings of this script

PXVIEW_VERSION=0.2.5

# go to the work directory
cd work

# get the source
wget -O pxview.tar.gz "http://sourceforge.net/projects/pxlib/files/pxview/$PXVIEW_VERSION/pxview_$PXVIEW_VERSION.orig.tar.gz/download"

# unarchive
tar -xzf pxview.tar.gz

# go to the source directory
cd "pxview-$PXVIEW_VERSION"

# build
./configure
make

#

# TODO
echo TODO
