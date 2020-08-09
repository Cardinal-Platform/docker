#!/bin/bash
get_latest_version(){
    curl --silent "https://api.github.com/repos/vidar-team/Cardinal/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}
latest_version=$(get_latest_version)
confirm() {
    read -r -p "${1:-[+][Warning] Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}
echo -e "\n[+][Info] The latest version of Cardinal is ${latest_version}."
echo -e "\n[+][Info] If you continue, this script will clean './Cardinal/*' './Cardinal_database'"
echo -e "\n[+][Warning] Please backup them before run continue."
confirm || { rm -rf ./Cardinal; rm -rf ./Cardinal_*.tar.gz && echo -e "\n[+][Info] User aborted. Bye~" && exit -1; }
echo -e "\n[+][info] Continue."
curl -L -O "https://github.com/vidar-team/Cardinal/releases/download/${latest_version}/Cardinal_${latest_version}_linux_amd64.tar.gz"
mkdir Cardinal 
tar xvzf Cardinal_*.tar.gz -C Cardinal
rm -rf ./Cardinal_*.tar.gz
curl -L -O "https://sh.cardinal.ink/Dockerfile"
curl -L -O "https://sh.cardinal.ink/docker-compose.yml"
docker-compose up -d
rm -rf ./Cardinal
