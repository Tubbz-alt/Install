#!/bin/bash
#Gumbo parser
	#Dependances
	sudo apt-get install libtool
	sudo apt-get install automake
	sudo apt-get install cmake

	sudo apt-get install libgtest-dev
	cd /usr/src/gtest
    	sudo cmake CMakeLists.txt
   	sudo make
    	sudo cp *.a /usr/lib


	#Install
	cd Sources
	unzip Sources/gumbo-parser-master.zip
	cd gumbo-parser-master
	./autogen.sh
	./configure
	make -j 2
	sudo make install

	rm -r gumbo-parser-master

	#Correction des liens symboliques
	sudo /sbin/ldconfig -v

