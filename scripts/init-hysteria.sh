#!/bin/bash
echo "mode: hysteria"
ENV_VARS="AIRPLANE_DOMAIN HYSTERIA_PASSWORD"

mkdir -p /etc/hysteria
cp /src/hysteria.yaml /etc/hysteria/hysteria.yaml

FILE_PATHS="/etc/hysteria/hysteria.yaml"
for FILE_PATH in $FILE_PATHS; do
  for VAR in $ENV_VARS; do
    VALUE=$(eval echo \$$VAR)
    echo "$(sed -e "s|\$$VAR|$VALUE|g" $FILE_PATH)" > $FILE_PATH
    echo "$VAR=$VALUE"
  done
done

hysteria server -c /etc/hysteria/hysteria.yaml