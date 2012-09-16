# makefile for simplre processing of profoto-dump tasks

PXLIB_VERSION=0.6.5

PXVIEW_VERSION=0.2.5

# generic  targets

.PHONY: all clean

all: pxview.elf

clean: clean_pxview.tar.gz clean_pxlib.tar.gz

# --- pxlib ---

# get the source
pxlib.tar.gz:
	wget -O pxlib.tar.gz "http://sourceforge.net/projects/pxlib/files/pxlib/$(PXLIB_VERSION)/pxlib-$(PXLIB_VERSION).tar.gz/download"

# clean up downloaded file
clean_pxlib.tar.gz: clean_pxlib-$(PXLIB_VERSION)
	rm -f pxlib.tar.gz


# unpack sources
pxlib-$(PXLIB_VERSION): pxlib.tar.gz
	tar -xzf pxlib.tar.gz

# clean unpacked sources
clean_pxlib-$(PXLIB_VERSION): clean_pxlib
	rm -rf pxlib-$(PXLIB_VERSION)

# build
# executable
pxlib: pxlib-$(PXLIB_VERSION)
	# build
		# FIXME "CPPFLAGS="-fno-stack-protector"" is needed to work around
		# a bug in libpx, that causes "stack smashing detected" error
	cd "pxlib-$(PXLIB_VERSION)";  CPPFLAGS="-fno-stack-protector" ./configure --prefix="`pwd`/../pxlib"
	cd "pxlib-$(PXLIB_VERSION)"; make ; make install

clean_pxlib:
	rm -rf pxlib

# --- pxview ---

# getting the source code
pxview.tar.gz:
	wget -O pxview.tar.gz "http://sourceforge.net/projects/pxlib/files/pxview/$(PXVIEW_VERSION)/pxview_$(PXVIEW_VERSION).orig.tar.gz/download"

# clean downloaded file
clean_pxview.tar.gz: clean_pxview-$(PXVIEW_VERSION)
	rm -f pxview.tar.gz


# unpacking the source
pxview-$(PXVIEW_VERSION): pxview.tar.gz
	tar -xzf pxview.tar.gz

# clean unpacked source
clean_pxview-$(PXVIEW_VERSION): clean_pxview.elf
	rm -rf pxview-$(PXVIEW_VERSION)

pxview-$(PXVIEW_VERSION)/patched: pxview-$(PXVIEW_VERSION)
	cd "pxview-$(PXVIEW_VERSION)" ; patch -p1 < "../patch-pxview-$(PXVIEW_VERSION).patch"
	echo "1" > "pxview-$(PXVIEW_VERSION)/patched"

# executable
pxview.elf: pxview-$(PXVIEW_VERSION)/patched pxlib
	# build
		# FIXME "LIBS=-lm" is needed to work around a configure bug
		# that causes configure to fail to find libpx
	cd "pxview-$(PXVIEW_VERSION)"; LIBS=-lm ./configure --with-pxlib="`pwd`/../pxlib"
	cd "pxview-$(PXVIEW_VERSION)" ; make
	# copy executable
	cp pxview-$(PXVIEW_VERSION)/src/pxview pxview.elf

# clean executable
clean_pxview.elf:
	rm -f pxview.elf

## -- end --
