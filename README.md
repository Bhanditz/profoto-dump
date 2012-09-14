profoto-dump, an utility for viewing pictures stored in the Profoto program
============

Introduction
============
Profoto is a program used to store and view pictures, generally on a CD.
This program only works on Windows operating system.
In order to allow viewing the pictures stored in this program on
UNIX-like operating systems,
the profoto-dump utility has been created.

Profoto internally uses Paradox database:

		http://en.wikipedia.org/wiki/Paradox_(database)

A description of this format can be found here:

		http://www.randybeck.com/paradoxformat.shtml

In this program pxlib is used to read the database
and extract the pictures.

		http://pxlib.sourceforge.net/index.php
		http://sourceforge.net/projects/pxlib/

Instructions
============

1. Install software development tools for your distribution
	because you will need to comple a program from source code.
	On Debian or Ubuntu distributions you can install the package
	called build-essential.
2. Install pxlib and pxlib-dev. Its homepage is:

			http://pxlib.sourceforge.net/index.php
			http://sourceforge.net/projects/pxlib/

	Probably your linux distribution already contains this library in
	packages named pxlib1 and pxlib-dev, or similar.


A. Automatic method
-------------------

Ensure that you have internet connectivity, and then run the scripts
prepare-profoto-dump and profoto-dump

			./prepare-profoto-dump.sh
			./profoto-dump.sh location_of_your_profoto_data

or combined in one run (\ means here new line wrapping):

			./prepare-profoto-dump.sh ; \
				./profoto-dump.sh location_of_your_profoto_data

B. Manual method
----------------

1. download pxview source code from

			http://sourceforge.net/projects/pxlib/files

2.

- edit the source code: pxview-*/src/main.c, line 2187:
	change:
		sprintf(filename, "%s_%d.%s", blobprefix, mod_nr, blobextension);
	to:
		sprintf(filename, "%s_%d_%d.%s", blobprefix, mod_nr, j, blobextension);

	This change is needed in order to prevent pxview from overwriting the image files.

- run pixview:
	FOTO_DIR - location of .db and .MB files. there are multiple directories:
		profoto/ profoto/*/
	pxview FOTO_DIR/profoto.db -b FOTO_DIR/profoto.MB -p img --blobextension=bmp -x -o index.htm

	For each directory, run pxview in a separate directory, otherwise the data will be overwritten.

- you will get files with names:
	img_*.bmp
	Those are the pictures.

--
