#!/usr/bin/env bash
#===============================================================================
#
#          FILE: clone-build.sh
# 
#         USAGE: ./clone-build.sh 
# 
#   DESCRIPTION: Script that will automatically clone latest version of my
#		 portfolio from github.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aleksandar Babic, 
#  ORGANIZATION: NA
#       CREATED: 27.11.2017. 00:31:31
#      REVISION: 0.1
#===============================================================================

set -o nounset                              # Treat unset variables as an error

OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`
REPOSITORY='https://github.com/aleksandar-babic/portfolio'
service=docker

if [ "${OS}" = "SunOS" ] ; then
    OS=Solaris
    ARCH=`uname -p` 
    OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
    echo "Sorry, this wont work on ${OSSTR}."
    exit 1
elif [ "${OS}" = "AIX" ] ; then
    OSSTR="${OS} `oslevel` (`oslevel -r`)"
    echo "Sorry, this wont work on ${OSSTR}."
    exit 1
elif [ "${OS}" = "Linux" ] ; then
    KERNEL=`uname -r`
    if [ -f /etc/redhat-release ] ; then
	echo "Detected Redhat based distribution"
	if ! [ -x "$(command -v git)" ]; then
  		echo "Git is not installed, will install it now"
		yum -y install git
	fi
		echo "Cloning portfolio from Github"
		git clone $REPOSITORY
	if ! [ -x "$(command -v docker)" ]; then
		echo "Docker is not installed, installing docker and docker-compose now"
		yum -y install docker docker-compose
	elif ! [ -x "$(command -v docker-compose)" ]; then
		echo "Docker is installed, but docker-compose is not, installing docker-compose now"
		yum -y install docker-compose
	fi
	echo "Checking if docker is started.."
	if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )); then
		echo "Docker is already started"
	else
		service $service start
	fi
		if docker-compose build ; then
			echo "Docker image is built, you can start container with docker-compose up"
			exit 0
		else 
			echo "docker-compose build failed"
			exit 1
		fi
    elif [ -f /etc/debian_version ] ; then
	#TODO Add Debian support
        echo "Detected Debian based distribution"
        exit 1
    fi
fi


