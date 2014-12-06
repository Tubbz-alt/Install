#! /bin/sh

if [ whoami!="root" ]
then 
	echo "Operation not permitted"
	return 0
fi

apt-get update
apt-get upgrade
apt-get install build-essential cmake
