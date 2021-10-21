#!/bin/bash

# check the if root?
userid=`id -u`
if [ $userid -ne "0" ]; then
#	echo "you're not root?"
	exit 1
fi

func_readip()
{
	if [ ! -x /bin/updatepostgressql ];then
		echo "[ Copy file ... ]"
		dpkg -i libpq5_10.17-0ubuntu0.18.04.1_amd64.deb
		chmod 777 updatepostgressql update_postgressql ethhotplug eth_hotplug
		cp updatepostgressql  /bin/ -f
		cp update_postgressql /bin/ -f
		cp ethhotplug   /bin/ -f
		cp eth_hotplug  /bin/ -f
		cp update-postgressql.service  /lib/systemd/system/ -f
		cp work-eth-hotplug.service  /lib/systemd/system/ -f
		cp docker-compose-Linux-x86_64 /usr/bin/docker-compose -f 
		systemctl enable update-postgressql.service
		systemctl enable work-eth-hotplug.service
	else
		echo "[ File already exists ]"
	fi
}
sync

func_startdocker()
{
	docker-compose -f docker-compose.yml up -d
	sleep 15
	systemctl restart update-postgressql.service
	systemctl restart work-eth-hotplug.service
}

func_downloadgit()
{
	git pull
}

######### Main ############
func_readip
func_startdocker
