#!/bin/bash -e

function ERROR(){
	echo -e "\033[0;31;49m${1}\033[0m"
}

TOP=$(pwd)

version=$(lsb_release -i | awk '{print $3}')
if [[ "$version" == "Ubuntu" ]]; then
	UBUNTU=true
	version=$(lsb_release -c | awk '{print $2}')
	if [ "$version" == "xenial" ];then
		UBUNTU_xenial=true
	elif [[ "$version" == "14.04" ]]; then
		UBUNTU_14=true
	fi
fi
