#!/usr/bin/make

TC3ZIP = http://ducksarepeople.com/tdf/files/TC3.tar

# Start a TurboC Compatable DOSBOX instance
run:
	utils/rundos

# Builds the documentation, this requires the docbook-xsl package (for
# Ubuntu systems)
XSL=/usr/bin/xsltproc
XSL_LOC=/usr/share/xml/docbook/stylesheet/nwalsh/xhtml/docbook.xsl
docs:
	mkdir -p doc/html
	${XSL} --xinclude --output doc/html/devel.html ${XSL_LOC} \
		doc/devel/devel.xml
	${XSL} --xinclude --output doc/html/user.html ${XSL_LOC} \
		doc/user/user.xml


# Aquire TurboC zip files, decompress, put into
# ./tc/APP/, configure as necessary to make running 
# TurboC less painful than normally.
env:
	mkdir -p tc
	wget ${TC3ZIP}
	mv TC3.tar tc.tar
	tar -xf tc.tar
	mv tc3/* tc/
	unzip -u ./tc/TC-Asm.zip -d ./tc/TASM
	unzip -u ./tc/TC-Debug.zip -d ./tc/TD
	unzip -u ./tc/TC-Prof.zip -d ./tc/TPROF
	unzip -u ./tc/TurboC3.zip -d ./
	mv ./TURBOC3/ ./tc/TC
	rm -f ./tc.tar ./tc/*.zip

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

# Make the TDF from source,
# install it into ./target/
tdf:
