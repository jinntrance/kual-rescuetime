#!/bin/bash

BASE=`dirname "$0"`
source $BASE/../bin/env.sh

LOG_PREFIX=log/metrics_reader_
CURRENT_LOG=$BASEDIR/$LOG_PREFIX`date +%y%m`
LATEST_LOG=$BASEDIR/log/reading_duration
awk -F,  '$6=="logAppActiveDuration"{printf strftime("%F %T", $3-$NF/1000) "," $1 "\n"}' $CURRENT_LOG > $LATEST_LOG

while IFS=, read start_dt end_dt; do
    #ret=`echo "$start" "$end"`
    ret=`bash $BASEDIR/bin/log.sh "$start_dt" "$end_dt"`
    case $ret in
        *Congrat*)
            echo $ret
            eips 22 0 "Synced $start_dt"
            sed -i "/$end_dt/d" $CURRENT_LOG
            ;;
        *)
            eips 22 0 "Failed to sync RescueTime"
            #eips 9 36 -h "$ret"
            ;;
    esac
done < $LATEST_LOG