#!/bin/sh

cp ~/.docker/config.json.off ~/.docker/config.json
docker kill docker-proxy
