#!/bin/bash

ENV_LIST=$(find . -name "env.sh")
INSTALL=$(find . -name "install.sh")

for env in $ENV_LIST
do
	INFO_INCLUDE "$env"
	. $env
done

for install in $INSTALL
do
	INFO_INCLUDE "$install"
	. $install
done
