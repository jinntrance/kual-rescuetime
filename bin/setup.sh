#!/bin/sh
BASEDIR=/mnt/us/extensions/rescuetime

## enable
rescuetime_enable()
{
	mntroot rw
	cp /etc/syslog-ng/syslog-ng.conf $BASEDIR/etc/syslog-ng.conf.bak
	cat $BASEDIR/etc/syslog-ng.conf.bak $BASEDIR/etc/rescuetime.conf > /etc/syslog-ng/syslog-ng.conf
	if [[  "`grep -c rescuetime /etc/crontab/root`" ]] ; then
	    echo "*/60 * * * * bash $BASEDIR/sync.sh" >> /etc/crontab/root
	fi
	cat /etc/crontab/root
	mntroot ro
	touch ./etc/enable
}

## disable
rescuetime_disable()
{
	mntroot rw
	rm -f /etc/syslog-ng/syslog-ng.conf
	cp $BASEDIR/etc/syslog-ng.conf.bak /etc/syslog-ng/syslog-ng.conf
	sed -i '/rescuetime/d' /etc/crontab/root
	mntroot ro
	rm -f ./etc/enable
}


## reset
rescuetime_reset()
{
	rm -f ./log/*
	usleep 150000
	eips 15 35 "Reset success"
	usleep 1000000
	eips 15 35 "             "
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
		rescuetime_reset
	;;
	* )
	;;
esac