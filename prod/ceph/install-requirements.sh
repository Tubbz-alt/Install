#!/bin/bash

nodes=( 92.222.69.137 92.222.69.8)
monitors=(92.222.68.171 )

username="Ceph"
adminnode="127.0.0.1"

##Node 
preflight () {
	ssh -l $login $1 sudo apt-get install ntp
	ssh -l $login $1 sudo apt-get install openssh-server


	ssh -l $login $1 sudo useradd -d /home/$username -m $username
	ssh -l $login $1 sudo passwd $username

	ssh -l $login $1 echo "$username ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username
	ssh -l $login $1 sudo chmod 0440 /etc/sudoers.d/$username	
}


adminnode_preflight(){
	wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
	echo deb http://ceph.com/debian-giant/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
	sudo apt-get update && sudo apt-get install ceph-deploy openssh-client
	
	echo "localhost adminnode" | sudo tee --append /etc/hosts

	i=0
	#ssh-keygen
	for node in ${nodes[@]}; do
		#ssh-copy-id  $username@$node
		echo "$node node$i" | sudo tee --append /etc/hosts
		echo "Host node$i"	>> ~/.ssh/config
		echo "	HostName $node"	>> ~/.ssh/config
		echo "	Port 22"	>> ~/.ssh/config
		echo "	User $username"	>> ~/.ssh/config	
		echo "	IdentityFile id_rsa"	>> ~/.ssh/config	

		preflight $node 
		((i++))	
	done;
	
	i=0
	for monitor in ${monitors[@]}; do
		#ssh-copy-id  $username@$monitor 
		echo "$node mon$i" | sudo tee --append /etc/hosts
		echo "Host mon$i"	>> ~/.ssh/config
		echo "	HostName $monitor">> ~/.ssh/config
		echo "	Port 22"	>> ~/.ssh/config
		echo "	User $username"	>> ~/.ssh/config	
		echo "	IdentityFile id_rsa"	>> ~/.ssh/config	

		preflight $node 
		((i++))	
	done;
}

deploy(){
	mkdir my-cluster
	cd my-cluster
	

	n1=${#monitors[@]}
	for (( i=0; i<${n1}; i++ ));
	do
	  	ceph-deploy new "mon$i"
		ceph-deploy install "mon$i"
	done

	n2=${#nodes[@]}
	for (( i=0; i<${n2}; i++ ));
	do
	  	ceph-deploy install "node$i"
	done
	#ceph-deploy install "adminnode"
	
}

adminnode_preflight
deploy

