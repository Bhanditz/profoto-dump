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

2. Select one of the two methods below. If you are unsure,
	then select the first one, marked with A.

A. Automatic method
-------------------

Ensure that you have internet connectivity, and then run the scripts
prepare-profoto-dump and profoto-dump:

			./prepare-profoto-dump.sh
			./profoto-dump.sh location_of_your_profoto_cd

or combined in one run (\ means here new line wrapping):

			./prepare-profoto-dump.sh ; \
				./profoto-dump.sh location_of_your_profoto_cd

B. Manual method
----------------

1. download pxlib source code from

			http://sourceforge.net/projects/pxlib/files/pxlib/

2. decompress the arhive, and run the configure script this way:

			CPPFLAGS=="-fno-stack-protector" ./configure --prefix=/your_preferred_location

	The -fno-stack-protector flag is needed because by default GCC will
	generate stack checking code, and pxview would print
	"stack smashing detected" error at each run.

	Run make and install as usual.

3. download pxview source code from

			http://sourceforge.net/projects/pxlib/files

4. decompress the arhive and run the configure script this way:

			LIBS=-lm ./configure --with-pxlib=/where_you_installed_pxlib

	The -lm flag links in the math library; this is required for the
	configure script, in order to find the manually compiled pxlib.

5. edit the source code: pxview-*/src/main.c, line 2187:
	change:
		sprintf(filename, "%s_%d.%s", blobprefix, mod_nr, blobextension);
	to:
		sprintf(filename, "%s_%d_%d.%s", blobprefix, mod_nr, j, blobextension);

	This change is needed in order to prevent pxview from overwriting the image files.

6. run pixview:
	FOTO_DIR - location of .db and .MB files. there are multiple directories:
		profoto/ profoto/*/

		pxview FOTO_DIR/profoto.db -b FOTO_DIR/profoto.MB -p img --blobextension=bmp -x -o index.htm

	For each directory, run pxview in a separate directory, otherwise the data will be overwritten.

7. you will get files with names:
	img_*.bmp
	Those are the pictures.

	Other data is stored in the generated index.htm files.

--
