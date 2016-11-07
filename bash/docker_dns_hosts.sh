#!/bin/bash
echo 'This is a list of all containers with ip addresses'
docker ps | sed -nr '2,${s/.* //;p}' | while read CID; do
    IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CID)
    CHN=$(docker inspect --format='{{.Config.Hostname}}' $CID)
    echo "$IP $CHN"
done | sort
