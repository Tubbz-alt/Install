#! /bin/sh

CURRENT_DIR=`dirname $0` #Dossier parent du script d'installation


apt-get update
apt-get upgrade

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc
apt-get update
apt-get install -y rabbitmq-server

invoke-rc.d rabbitmq-server start

rabbitmqctl add_user artemis artemis
rabbitmqctl set_user_tags artemis administrator
rabbitmqctl set_permissions -p / artemis ".*" ".*" ".*"

###
###	BEGIN FIREWALL
###
#cp $CURRENT_DIR/firewall-rabbitmq.sh /etc/init.d/firewall.sh
		
#chmod +x /etc/init.d/firewall.sh
#/etc/init.d/firewall.sh
		
#update-rc.d firewall.sh defaults
###
###	END FIREWALL
###
