#!/bin/bash

# if [ `whoami` != "root" ];then
# 	echo "please run as root!!"
# 	exit
# fi

if [ "$1" == "" ];then
	echo "please input output!"
	exit
fi

OUTPUT="$1"

. script/env.sh
. script/wget.sh

cd linux
. linux.sh
cd ..