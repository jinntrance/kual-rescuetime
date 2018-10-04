#!/bin/bash
BASE=`dirname "$0"`
source $BASE/../bin/env.sh
# Create your own IFTTT applet at https://ifttt.com/applets/86337494d-log-kindle-reading-duration-to-rescuetime
# Then look at https://ifttt.com/maker_webhooks, Documentations to find you key
url="https://maker.ifttt.com/trigger/Reading/with/key/$key"
if [ -z "$1" ]; then
  echo "usage log.sh start_datetime [end_datetime]|now"
  exit
fi
begin_datetime="$1"
if [[ "$2" ]]; then
  end_datetime="$2"
else
  end_datetime=`date +'%F %T'`
fi
data="{'value1':'$begin_datetime','value2':'$end_datetime','value3':'on Kindle'}"
data=${data//"'"/'"'}

curl -X POST $url -H 'Content-Type: application/json' -d "$data"
