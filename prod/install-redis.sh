#! /bin/sh

###
### BEGIN DEPENDENCES
###
apt-get update
apt-get upgrade
apt-get install build-essential cmake tcl8.5
###
### END DEPENDENCES
###

wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make test
make install



### Conf
mkdir /etc/redis
mkdir /var/redis
cp utils/redis_init_script /etc/init.d/redis_6379
mkdir /var/redis/6379
update-rc.d redis_6379 defaults

cd ..
rm -r redis-stable
rm redis-stable.tar.gz

cp conf/redis.conf /etc/redis/6379.conf

/etc/init.d/redis_6379 start


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
