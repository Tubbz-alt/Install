#! /bin/sh

CURRENT_DIR=`dirname $0` #Dossier parent du script d'installation


apt-get update
apt-get upgrade
apt-get install -y mysql-server

#Conf
cp $CURRENT_DIR/conf/my.cnf /etc/mysql/my.cnf

mysqladmin -u root password "rj7@kAv;8d7_e(E6:m4-w&"
mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -e "grant all privileges on *.* to 'root'@'%' identified by 'rj7@kAv;8d7_e(E6:m4-w&';"



mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -e "CREATE DATABASE artemis"
mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -D artemis -e "SOURCE $CURRENT_DIR/../artemis.sql"
mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -e "CREATE DATABASE mnemosyne"
mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -D mnemosyne -e "SOURCE $CURRENT_DIR/../mnemosyne.sql"

service mysql restart

#apt-get install -y phpmyadmin

###
###	BEGIN FIREWALL
###
#cp $CURRENT_DIR/firewall-mysql.sh /etc/init.d/firewall.sh
		
#chmod +x /etc/init.d/firewall.sh
#/etc/init.d/firewall.sh
		
#update-rc.d firewall.sh defaults
###
###	END FIREWALL
###
