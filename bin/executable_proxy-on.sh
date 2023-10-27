#!/bin/sh
# Run the container
docker run -d --rm \
  --name docker-proxy \
  -p 3128:3128 \
  -e http_proxy="" \
  -e https_proxy="" \
  -e HTTP_PROXY="" \
  -e HTTPS_PROXY="" \
  registry.gitlab.com/trovio/tech/image/docker-proxy:latest

# If you already have a ~/.docker/config.json, we will back it up
# to ~/.docker/config.json.<timestamp>
touch ~/.docker/config.json
cp ~/.docker/config.json ~/.docker/config.json.$(date +%Y%m%d%H%M%S)
mv ~/.docker/config.json ~/.docker/config.json.off


# On MacOS and WSL2, you can use host.docker.internal to access the host
# Modify ~/.docker/config.json to use the proxy
jq '.proxies = {
    "default": {
        "httpProxy": "http://host.docker.internal:3128",
        "httpsProxy": "http://host.docker.internal:3128",
        "noProxy": "127.0.0.1,localhost"
    }
}'  ~/.docker/config.json.off >  ~/.docker/config.json



# If you are on linux and use docker version 20.10 or lower, you need to
# replace host.docker.internal with your host ip address or run docker
# with --add-host=host.docker.internal:host-gateway. See also README.md

# export ipaddr=$(ifconfig eth0 |awk '$1=="inet" {print $2}')
# echo "Your ip-address is $ipaddr"

# jq '.proxies = {
#     "default": {
#         "httpProxy": "http://'"$ipaddr"':3128",
#         "httpsProxy": "http://'"$ipaddr"':3128",
#         "noProxy": "127.0.0.1,localhost"
#     }
# }'  ~/.docker/config.json.off >  ~/.docker/config.json
