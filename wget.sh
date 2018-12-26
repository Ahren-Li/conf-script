#!/bin/bash

function make_cmd(){
	cmd="wget"
	proxy_prefix="http_proxy"

	if [[ ${1} =~ "https" ]];then
		proxy_prefix="https_proxy"
	fi

	cmd+=" ${1} -O ${2}"

	if [ "$3" != "" ];then
		cmd+=" -e ${proxy_prefix}=${3}"
	fi

	echo ${cmd}
}

function FILE_WGET(){
	url=$1
	out_name=$2
	out_file=$3
	md5_path=$4
	proxy_use=$5

	result=$(FILE_CHECK "${out_file}" "${md5_path}")

	if(($result > 0));then
		INFO "${out_name} is already install."
		return
	fi

	mkdir -p `dirname ${out_file}`

	$(make_cmd "${url}" "${out_file}" "${proxy_use}")
	chmod 755 ${out_file}

	result=$(FILE_CHECK "${out_file}" "${md5_path}")
	if(($result > 0));then
		INFO "${out_name} is installed."
	else
		ERROR "${out_name} not install!"
	fi
}