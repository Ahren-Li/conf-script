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
		INFO_SW "${out_name} is already download."
		return 1
	fi

	mkdir -p `dirname ${out_file}`

	$(make_cmd "${url}" "${out_file}" "${proxy_use}")
	chmod 755 ${out_file}

	result=$(FILE_CHECK "${out_file}" "${md5_path}")
	if(($result > 0));then
		INFO_SW "${out_name} is download."
		return 0
	else
		ERROR "${out_name} not download!"
		return -1
	fi
}

function DEB_WGET(){
	url=$1
	out_file="/tmp/install.deb"
	proxy_use=$2

	$(make_cmd "${url}" "${out_file}" "${proxy_use}")
	if [ "0" == "$?" ];then
		chmod 755 ${out_file}
		dpkg -i ${out_file}
		if [ "0" == "$?" ];then
			return 0
		fi
	fi

	return -1
}

function ZIP_WGET(){
	url=$1
	out_name=$2
	out_file=$3
	md5_path=$4
	proxy_use=$5

	FILE_WGET $@

	if [ "-1" == "$?" ];then
		return -1
	fi

	IS_EXTRACT_OK `dirname ${out_file}`
	if [ "0" == "$?" ];then
		return 0
	fi

	unzip ${out_file} -d `dirname ${out_file}`
	if [ "0" == "$?" ];then
		DO_EXTRACT_OK `dirname ${out_file}`
		return 0
	fi
	return -1
}

function TAR_WGET(){
	url=$1
	out_name=$2
	out_file=$3
	md5_path=$4
	proxy_use=$5

	FILE_WGET $@

	if [ "-1" == "$?" ];then
		return -1
	fi

	IS_EXTRACT_OK $(dirname ${out_file}) ${out_name}
	if [ "0" == "$?" ];then
		return 0
	fi

	tar -xf ${out_file} -C `dirname ${out_file}`
	if [ "0" == "$?" ];then
		DO_EXTRACT_OK $(dirname ${out_file}) ${out_name}
		return 0
	fi
	return -1
}