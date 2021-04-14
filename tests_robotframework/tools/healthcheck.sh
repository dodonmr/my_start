#!/usr/bin/env bash

echo "Checking if hub is ready "

while [ "$( curl -s http://localhost:4444/wd/hub/status | jq -r .value.ready )" != "true" ]
do
	sleep 1
done

