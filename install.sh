#!/bin/bash

if [ `whoami` != "root" ];then
	echo "please run as root!!"
	exit
fi

. script/env.sh

CORE_SW=""
PPA_SW=""
SW="vim git docker python"

cd linux
. linux.sh
cd ..