#!/bin/bash

sqlservers=()
redisservers=()
slaves=(92.222.73.130   ) #ip1 to n

login=admin
sqlmdp="rj7@kAv;8d7_e(E6:m4-w&"


artemis=/home/toor/Github/Athena/Artemis/trunk
mnemosyne=/home/toor/Github/Athena/Mnemosyne/trunk
sql=/home/toor/Github/Athena/Install/trunk/prod
redis=/home/toor/Github/Athena/Install/trunk/prod



# this is the slow running function
slave_install () {
	#scp -r $mnemosyne $login@$1:Mnemosyne
	scp -r $artemis $login@$1:Artemis

	#ssh -l $login $1 sudo bash Mnemosyne/install/install.sh
	ssh -l $login $1 sudo bash Artemis/install/install.sh

	ssh -l $login $1 sudo rm -r Mnemosyne Artemis
	#ssh -l $login $1 sudo reboot 
}

sql_install () {
	scp -r $sql $login@$1:Sql
	scp -r $artemis/install/tables.sql $login@$1:artemis.sql
	scp -r $mnemosyne/install/table.sql $login@$1:mnemosyne.sql
	
	ssh -l $login $1 sudo bash Sql/install-mysql.sh

	ssh -l $login $1 sudo rm -r Sql



	#ssh -l $login $1 sudo reboot 
}

redis_install () {
	scp -r $redis $login@$1:Redis

	ssh -l $login $1 sudo bash Redis/install-redis.sh

	ssh -l $login $1 sudo rm -r Redis
	#ssh -l $login $1 sudo reboot 
}



for i in ${sqlservers[@]}; do
	sql_install $i &
done;


echo waiting
wait
echo done waiting

for i in ${redisservers[@]}; do
	redis_install $i &
done;



echo waiting
wait
echo done waiting


for i in ${slaves[@]}; do
	slave_install $i &
done;




