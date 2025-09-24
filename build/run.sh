#!/bin/sh

# This script requires jq

ACTION=$1

if [ "$ACTION" = "--update" ] || [ "$ACTION" = "-u" ];
then
  if [ -e ./server.jar ]
  then
    rm ./server.jar
  fi

  PAPERMC_URL=$(curl -s -H "User-Agent: container-updater" https://fill.papermc.io/v3/projects/paper/versions/$2/builds | jq -r 'first(.[] | select(.channel == "STABLE") | .downloads."server:default".url) // "null"')

  if [ "$PAPERMC_URL" != "null" ]; then
    curl -o server.jar $PAPERMC_URL
    echo "Download completed"
  else
    echo "No stable build for version $MINECRAFT_VERSION."
  fi
else
  exec java "$@" -jar ./server.jar --nogui
fi

