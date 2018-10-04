#!/bin/bash

BASE=`dirname "$0"`
source $BASE/../bin/env.sh

rescuetime_enable()
{
	mntroot rw
	cp /etc/syslog-ng/syslog-ng.conf $BASEDIR/etc/syslog-ng.conf.bak
	cat $BASEDIR/etc/syslog-ng.conf.bak $BASEDIR/etc/rescuetime.conf > /etc/syslog-ng/syslog-ng.conf
	if [[  "`grep -c rescuetime /etc/crontab/root`" ]] ; then
	    echo "*/60 * * * * bash $BASEDIR/bin/sync.sh" >> /etc/crontab/root
	fi
	eips 13 34 "RescueTime Enabled"
	cat /etc/crontab/root
	mntroot ro
	touch ./etc/enable
}

rescuetime_disable()
{
	mntroot rw
	rm -f /etc/syslog-ng/syslog-ng.conf
	cp $BASEDIR/etc/syslog-ng.conf.bak /etc/syslog-ng/syslog-ng.conf
	sed -i '/rescuetime/d' /etc/crontab/root
	eips 13 34 "RescueTime Disabled"
	mntroot ro
	rm -f ./etc/enable
}

rescuetime_clear()
{
	rm -f ./log/*
	eips 15 35 "Log Cleared"
	usleep 1000000
}

## Main
case "$1" in
	"enable" )
		rescuetime_enable
	;;
	"disable" )
		rescuetime_disable
	;;
	"reset" )
		rescuetime_clear
	;;
	* )
	;;
esac