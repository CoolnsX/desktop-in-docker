#!/bin/sh

#my shell script to build the image

info(){
	printf '\033[1;35m=> \033[1;36m%s\033[0m\n' "$1"
}

success(){
	printf '\033[1;35m=> \033[1;32m%s\033[0m\n' "$1"
}

error(){
	printf '\033[1;35m=> \033[1;31m%s\033[0m' "$1"
}

#vs code
[ -f "code.deb" ] && rm "code.deb" "code.deb.aria2" -f && info "Removed Old VS Code.deb file"
[ -f "upwork.deb" ] && rm "upwork.deb" "code.deb.aria2" -f && info "Removed Old Upwork.deb file"
info "Downloading VS-Code and Upwork.."
printf "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64\n\tout=code.deb\n%s\n\tout=upwork.deb" "$(curl --cipher 'AES256-SHA256' --tlsv1.3 -s "https://upwork-usw2-desktopapp.upwork.com/binaries/versions-linux.json" -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36" | sed -nE 's|.*linux-deb": "([^"]*)".*|\1|p' | head -1)" | aria2c -x16 -s16 -j2 --check-certificate=false --download-result=hide --summary-interval=0 -i - && success "VS-Code and Upwork Downloaded" || error "VS-code and Upwork Not Downloaded"

info "Creating New Image using base Image debian:testing and init.sh"
docker image rm coolans && info "Removed Previous coolans:latest image"

docker build -t coolans . && success "Successfully created Image, Bye" || error "Something went wrong"
