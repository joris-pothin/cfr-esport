#!/bin/sh

BASEDIR=$(dirname "$0")

source $BASEDIR/bash_aliases.sh
source $BASEDIR/../.env

addhost 127.0.0.1 service.mysql
addhost 127.0.0.1 ${NGINX_FRONT_SERVER_NAME}