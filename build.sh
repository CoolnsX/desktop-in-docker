#!/bin/sh

#my shell script to build the image
# shellcheck disable=SC2015,SC2086

info(){
	printf '\033[1;35m=> \033[1;36m%s\033[0m\n' "$1"
}

success(){
	printf '\033[1;35m=> \033[1;32m%s\033[0m\n' "$1"
}

error(){
	printf '\033[1;35m=> \033[1;31m%s\033[0m' "$1"
}

engine="podman"

command -v $engine >/dev/null || engine="docker"

#vs code and upwork installation
rm ./*.aria2 ./*.deb > /dev/null 2>&1 && info "Removed Old .deb files"
info "Downloading VS-Code and Upwork.."
printf "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64\n\tout=code.deb\n%s\n\tout=upwork.deb" "$(curl --cipher 'AES256-SHA256' --tlsv1.3 -s "https://upwork-usw2-desktopapp.upwork.com/binaries/versions-linux.json" -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36" | sed -nE 's|.*linux-deb": "([^"]*)".*|\1|p' | head -1)" | aria2c -x16 -s16 -j2 --check-certificate=false --download-result=hide --summary-interval=0 -i - && success "VS-Code and Upwork Downloaded" || error "VS-code and Upwork Not Downloaded"

info "Creating New Image using base Image debian:testing and init.sh with $engine backend"
$engine image rm ${1:-'coolans'} && info "Removed Previous ${1:-coolans}:latest image"

$engine build -t ${1:-'coolans'} . && success "Successfully created Image, Bye" || error "Something went wrong"
