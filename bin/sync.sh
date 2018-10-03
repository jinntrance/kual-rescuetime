#!/bin/bash
BASEDIR=/mnt/us/extensions/rescuetime
LOG_PREFIX=log/metrics_reader_
TODAY_LOG=$BASEDIR/$LOG_PREFIX`date +%y%m%d`
DAILY_LOG=$BASEDIR/log/daily_duration
awk -F,  '$6=="logAppActiveDuration"{printf strftime("%F %T", $3-$NF/1000) "," $1 "\n"}' $TODAY_LOG > $DAILY_LOG

while IFS=, read start_dt end_dt; do
    #ret=`echo "$start" "$end"`
    ret=`bash $BASEDIR/bin/log.sh "$start_dt" "$end_dt"`
    case $ret in
        *Congrat*)
            echo $ret
            eips 13 34 "$ret"
            usleep 150000
            sed -i "/$end_dt/d" $TODAY_LOG
            ;;
        *)
            echo "Failed when syncing RescueTime"
            echo $ret
            ;;
    esac
done < $DAILY_LOG