#!/bin/bash -e

function ERROR(){
	echo -e "\033[0;31;49m${1}\033[0m"
}

function _print(){
	f_color=${1}
	b_color=${2}

	if [ -z "$f_color" ];then
		f_color="32"
	fi

	if [ -z "$b_color" ];then
		b_color="49"
	fi

	echo -e "\033[0;${f_color};${b_color}m${3}\033[0m"
}

function INFO(){
	_print 39 49 "${1}"
}

function INFO_INCLUDE(){
	_print 39 49 "Include: ${1}"
}

function INFO_ENV(){
	_print 33 49 "ENV: ${1}"
}

function INFO_PPA(){
	_print 34 49 "PPA: ${1}"
}

function INFO_INSTALL(){
	_print 35 49 "INT: ${1}"
}

function INFO_SW(){
	_print 35 49 "SW : ${1}"
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

function ADD_CORE_SW(){
	CORE_SW_LIST+=" $1"
}

function ADD_SW(){
    SW_LIST+=" $1"
}

function ADD_PPA(){
	PPA_LIST+=" $1"
}

function ADD_PPA_KEY(){
	PPA_KEY_LIST+=" $1"
}

function IS_EXTRACT_OK(){
	out_dir=$1
	out_name=$2

	if [ -f "$1/.${out_name}.extract" ];then
		return 0
	fi
	return -1
}

function DO_EXTRACT_OK(){
	out_dir=$1
	out_name=$2

	touch $1/.${out_name}.extract
}

HTTP_PROXY="http://127.0.01:1080/"
HTTPS_PROXY="http://127.0.01:1080/"
TOP=$(pwd)

SW_LIST=""
PPA_LIST=""
CORE_SW_LIST=""
PPA_KEY_LIST=""

version=$(lsb_release -i | awk '{print $3}')
if [[ "$version" == "Ubuntu" ]]; then
	UBUNTU=true
	version=$(lsb_release -c | awk '{print $2}')
	if [ "$version" == "xenial" ];then
		UBUNTU_xenial=true
	elif [[ "$version" == "14.04" ]]; then
		UBUNTU_14=true
	fi
	sudo ls / > /dev/null
fi

. script/ubuntu_icon.sh