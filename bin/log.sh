#!/bin/bash
#Look at https://ifttt.com/maker_webhooks, Documentations to find you key
key='b78J2zmeqpYzeDKrmEpcr3'
url="https://maker.ifttt.com/trigger/Reading/with/key/$key"
echo "usage log.sh start_datetime [end_datetime]|now"
if [ -z "$1" ]; then
  exit
fi
begin_datetime="$1"
if [[ "$2" ]]; then
  end_datetime="$2"
else
  end_datetime=`date +'%F %T'`
fi
#create your own IFTTT applet https://ifttt.com/applets/86337494d-log-kindle-reading-duration-to-rescuetime
data="{'value1':'$begin_datetime','value2':'$end_datetime','value3':'Reading on Kindle'}"
data=${data//"'"/'"'}

curl -X POST $url -H 'Content-Type: application/json' -d "$data"
