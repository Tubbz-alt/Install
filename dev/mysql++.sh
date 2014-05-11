#!/bin/bash

	#Mysql server( à remplacer par MariaDB en prod), see scientiavulgaria config
	sudo apt-get install mysql-server #Server de test (mdp : root :) )

	sudo apt-get update
	sudo apt-get install libmysqlclient-dev
	sudo mkdir -p /usr/local/mysql/lib
	sudo ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so   /usr/local/mysql/lib/libmysqlclient.so  #petit pb de lib
	cd~
	
	wget http://tangentsoft.net/mysql++/releases/mysql++-3.2.1.tar.gz
	tar xvfz mysql++-3.2.1.tar.gz
	cd mysql++-3.2.1
	./configure --prefix=/usr
	make -j 3
	sudo make install
	rm mysql++-3.2.1

