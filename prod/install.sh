﻿#! /bin/sh

if [ whoami!="root" ]
then 
	echo "Operation not permitted"
	return 0
fi


ARTEMIS_BIN=	"/usr/opt/artemis"
ARTEMIS_CONF= 	"/etc/artemis "



### Dependances
## General
apt-get install liblzma-dev, libtar-dev
apt-get install python-dev, python3-pip

##Redis
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make install

rm -r redis-stable
rm redis-stable.tar.gz

#cp -v Config/php.ini /etc/php5/apache2/php.ini 
pip3 install redis

##MySQL
apt-get install mysql-server
mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -e "CREATE DATABASE artemis"

#cp -v Config/php.ini /etc/php5/apache2/php.ini 
pip3 install PyMySQL


### Structure
mkdir /usr/opt/artemis
mkdir /etc/artemis 

cp conf/* $ARTEMIS_CONF
cp lib/*  $ARTEMIS_BIN

cp init/* /etc/init.d/
chmod 0755 /etc/init.d/artemis-master
chmod 0755 /etc/init.d/artemis-slave
