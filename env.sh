#!/bin/bash -e

function ERROR(){
	echo -e "\033[0;31;49m${1}\033[0m"
}

function INFO(){
	echo -e "\033[0;32;49m${1}\033[0m"
}

function FILE_CHECK(){
	if(($# < 2));then
		echo "-1"
		return
	fi
	start_md5=`cat ${2}`
	if [ -f "${1}" ];then
		already_md5=`md5sum ${1} | awk '{print $1}'`
		if [[ "${already_md5}" == "${start_md5}" ]];then
			echo "1"
			return
		fi
	fi

	echo "0"
}

function INSTALL_ICON(){
	src_desktop=${1}
	dts_desktop=${2}
	icon_path=${3}
	exec_path=${4}

	cp ${src_desktop} ${dts_desktop}

	if [ -d "${dts_desktop}" ];then
		name=$(basename ${src_desktop})
		dts_desktop="${dts_desktop}/${name}"
	fi

	sed -i s/'\${icon}'/${icon_path//"/"/"\/"}/g ${dts_desktop}
	sed -i s/'\${path}'/${exec_path//"/"/"\/"}/g ${dts_desktop}
}

HTTP_PROXY="http://127.0.01:1080/"
HTTPS_PROXY="http://127.0.01:1080/"
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
