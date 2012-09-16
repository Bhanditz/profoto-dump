# makefile for simplre processing of profoto-dump tasks

PXVIEW_VERSION=0.2.5

# generic  targets

.PHONY: all clean

all: pxview.elf

clean: clean_pxview.tar.gz

# getting the source code
pxview.tar.gz:
	wget -O pxview.tar.gz "http://sourceforge.net/projects/pxlib/files/pxview/$(PXVIEW_VERSION)/pxview_$(PXVIEW_VERSION).orig.tar.gz/download"

# clean downloaded file
clean_pxview.tar.gz: clean_pxview-$(PXVIEW_VERSION)
	rm pxview.tar.gz


# unpacking the source
pxview-$(PXVIEW_VERSION): pxview.tar.gz
	tar -xzf pxview.tar.gz

# clean unpacked source
clean_pxview-$(PXVIEW_VERSION): clean_pxview.elf
	rm -rf pxview-$(PXVIEW_VERSION)


# executable
pxview.elf: pxview-$(PXVIEW_VERSION)
	# build
	cd "pxview-$(PXVIEW_VERSION)"; ./configure
	cd "pxview-$(PXVIEW_VERSION)" ; make
	# copy executable
	cp pxview-$(PXVIEW_VERSION)/src/pxview pxview.elf

# clean executable
clean_pxview.elf:
	rm -f pxview.elf

## -- end --
