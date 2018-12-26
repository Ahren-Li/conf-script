#!/bin/bash

if [ `whoami` != "root" ];then
	echo "please run as root!!"
	exit
fi

if [ "$1" == "" ];then
	echo "please input output!"
	exit
fi

. script/env.sh
. script/wget.sh

OUTPUT="$1"
CORE_SW=""
PPA_SW=""
SW="vim git docker python"

cd linux
. linux.sh
cd ..