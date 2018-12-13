#!/bin/bash

ENV_LIST=$(find . -name "env.sh")
INSTALL=$(find . -name "install.sh")

for env in $ENV_LIST
do
	. $env
done

for install in $INSTALL
do
	. $install
done
