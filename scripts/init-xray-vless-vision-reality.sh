#!/bin/sh
echo "mode: xray-vless-vision-reality"
ENV_VARS="AIRPLANE_DOMAIN VLESS_UUID REALITY_PRIVKEY REALITY_PUBKEY REALITY_SHORTID"

mkdir -p /etc/xray/confs
cp /src/00-base.server.json /etc/xray/confs/00-base.server.json
cp /src/110-inbounds-vless-vision-reality.server.json /etc/xray/confs/10-inbounds.server.json

FILE_PATHS="/etc/xray/confs/10-inbounds.server.json"
for FILE_PATH in $FILE_PATHS; do
  for VAR in $ENV_VARS; do
    VALUE=$(eval echo \$$VAR)
    echo "$(sed -e "s|\$$VAR|$VALUE|g" $FILE_PATH)" > $FILE_PATH
    echo "$VAR=$VALUE"
  done
done

/usr/bin/xray -confdir /etc/xray/confs