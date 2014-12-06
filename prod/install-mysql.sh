#! /bin/sh
apt-get update
apt-get upgrade
apt-get install mysql-server

#Conf
cp conf/my.cnf /etc/mysql/my.cnf

mysql -u root -p"rj7@kAv;8d7_e(E6:m4-w&" -e "grant all privileges on *.* to 'root'@'%' identified by 'rj7@kAv;8d7_e(E6:m4-w&';"

apt-get install phpmyadmin

###
###	BEGIN FIREWALL
###
cp -fv firewall-mysql.sh /etc/init.d/firewall.sh
		
chmod +x /etc/init.d/firewall.sh
/etc/init.d/firewall.sh
		
update-rc.d firewall.sh defaults
###
###	END FIREWALL
###
