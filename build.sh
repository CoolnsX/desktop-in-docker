#!/bin/sh

#my shell script to build the image
# shellcheck disable=SC2015,SC2086

print (){
	printf "\033[1;35m=> \033[1;${2:-36}m%s\033[0m\n" "$1"
}

engine="podman"

command -v $engine >/dev/null || engine="docker"

#vs code and upwork installation
urls="$(curl -s "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" | sed -nE 's|.*(https.*)|\1|p') $(curl --cipher 'AES256-SHA256' --tlsv1.3 -s "https://upwork-usw2-desktopapp.upwork.com/binaries/versions-linux.json" -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" | sed -nE 's|.*linux-deb": "([^"]*)".*|\1|p' | head -1)"
for i in $urls;do
	name=$(basename "$i")
	if [ -f "$name" ] && [ ! -f "$name.aria2" ];then
		continue
	else
		app="$(printf "%s" "$name" | cut -d'_' -f1)"
		rm -f "$app"*.deb*
		res="$i\n$res"
		apps="$app,$apps"
	fi
done

#shellcheck disable=SC2059
[ -n "$res" ] && print "Downloading $apps" && printf "$res" | aria2c -x16 -s16 -j2 --check-certificate=false --download-result=hide --summary-interval=0 -i - && print "VS-Code and Upwork Downloaded" "32"

print "Creating New Image using base Image debian:testing and init.sh with $engine backend"
$engine image rm ${1:-'coolans'} && print "Removed Previous ${1:-coolans}:latest image"

$engine build -t ${1:-'coolans'} . && print "Successfully created Image, Bye" "32" && exit 0
print "Something went wrong" "31"
