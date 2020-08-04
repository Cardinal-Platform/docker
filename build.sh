#!/bin/bash
get_latest_version(){
    curl --silent "https://api.github.com/repos/vidar-team/Cardinal/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}
latest_version=$(get_latest_version)
curl -L -O "https://github.com/vidar-team/Cardinal/releases/download/${latest_version}/Cardinal_${latest_version}_linux_amd64.tar.gz"
rm -rf Cardinal
mkdir Cardinal
tar xvzf Cardinal_* -C Cardinal
rm -rf Cardinal_*
curl -L -O "https://cardinal-platform.github.io/Cardinal-Docker/Dockerfile"
curl -L -O "https://cardinal-platform.github.io/Cardinal-Docker/docker-compose.yml"
docker-compose up -d