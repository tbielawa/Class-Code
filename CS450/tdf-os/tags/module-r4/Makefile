#!/usr/bin/make

TC3ZIP = http://ducksarepeople.com/tdf/files/tc.tar.bz2

# Start a TurboC Compatable DOSBOX instance
# Aliased as 'dosbox'
run:
	utils/rundos
dosbox: run

# Builds the documentation, this requires the docbook-xsl package (for
# Ubuntu systems)
docs:
	utils/build-docs

docs-pdf:
	utils/build-docs pdf

docs-html:
	utils/build-docs html

docs-all: docs docs-html docs-pdf

# Aquire TurboC zip files, decompress, put into
# ./tc/APP/, configure as necessary to make running 
# TurboC less painful than normally.
env:
	wget ${TC3ZIP}
	tar -xjf tc.tar.bz2
	rm tc.tar.bz2

# Boots DOSBOX, launches the TDF initializer.
boot:
	utils/runtdf

# Clean up any molested directories, emacs
# trash, and all trash left over from TurboC
clean:
	rm -rf doc/html
	rm -rf build/*
	find ./ -type f -name "*.SWP" -exec rm -vf {} +;
	find ./ -type f -name "*.DSK" -exec rm -vf {} +;
	find ./ -type f -name "*.BAK" -exec rm -vf {} +;
	find ./ -type f -name "*~" -exec rm -vf {} +;
	find ./ -type f -name "#*" -exec rm -vf {} +;

version:
	utils/version > src/etc/version

stats:
	utils/mkstats

# Clean the pseudo-root dir for tdf
tdf-clean:
	rm -fR target/*
	rm -fR build/*

# Launch into dosbox and run the commands
# to build tdf from source...
tdf-build: tdf-clean
	utils/buildtdf

# Put into target directory
tdf-install:
	mv build/TDF.EXE target/
	cp -r src/etc target/
	touch target/TEST1.MPX target/TEST2.MPX target/TEST50.MPX
	cp src/procs/* target/

# Run TDF
tdf-boot: boot

# Full tdf-* sequence,
# clean, build, run
tdf-all: tdf-clean version tdf-build tdf-install tdf-boot

