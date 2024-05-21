#!/bin/bash

# check the if root?
userid=`id -u`
if [ $userid -ne "0" ]; then
#	echo "you're not root?"
	exit 1
fi

func_randompasswd()
{
	flag=`cat .env |grep CUSTOM_FLAG|awk -F '=' '{print $2}'`
	if [ "$flag" == "" ] || [ "$flag" == "0" ];then
		#echo "flag=$flag"
		sed -i '/CUSTOM_FLAG/d' .env
		sed -i '/POSTGRES_PASSWORD/d' .env
		sed -i '/MQTT_PASSWORD/d' .env
		chmod 777 random_string && cp random_string /bin/ -f
		/bin/random_string |grep POSTGRES_PASSWORD >> .env
		/bin/random_string |grep MQTT_PASSWORD >> .env
		echo "CUSTOM_FLAG=1" >> .env
		cp .env   /bin/ -f 
		return 0
	else
		#echo "flag=$flag"
		return 1
	fi
}

func_readip()
{
	if [ ! -x /bin/updatepostgressql ];then
		echo "[ Copy file ... ]"
		dpkg -i libpq5*.deb
		chmod 777 updatepostgressql update_postgressql ethhotplug eth_hotplug
		cp updatepostgressql  /bin/ -f
		cp update_postgressql /bin/ -f
		cp ethhotplug   /bin/ -f
		cp eth_hotplug  /bin/ -f
		cp update-postgressql.service  /lib/systemd/system/ -f
		cp work-eth-hotplug.service  /lib/systemd/system/ -f
		cp docker-compose-Linux-x86_64 /usr/bin/docker-compose -f 
		sync
		systemctl enable update-postgressql.service
		systemctl enable work-eth-hotplug.service
	else
		echo "Apphub is Running, please input docker ps to view"
	fi
}

func_startdocker()
{
	docker-compose -f ./docker-compose.yml up -d
	sleep 25
	systemctl restart update-postgressql.service
	systemctl restart work-eth-hotplug.service
}

func_downloadgit()
{
	git pull
}

func_broadcast()
{
	echo "[INFO]Confirm systemctl status"
	systemdFlag=`systemctl --version`
	if [ -z "$systemdFlag" ]
	then
        	echo ""
        	echo "[ERROR]The systemctl is not supported"
        	echo "[ERROR]Please manual config for auto start broadcast when system boot to support wake system when shutdown"
        	echo ""
		
	else
	        echo "[INFO]The systemctl is supported"
		cp broadcast /bin/ -f
		cp AppHub-Broadcast.service /lib/systemd/system/ -f
		systemctl daemon-reload
		systemctl enable AppHub-Broadcast.service
		systemctl restart AppHub-Broadcast.service

	fi
	
}

######### Main ############
func_randompasswd
if [ $? -ne 0 ];then
	echo "The Apphub server is running."
	exit 1
fi
func_readip
func_startdocker
func_broadcast
echo "success"
