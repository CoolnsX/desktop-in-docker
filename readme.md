# Desktop In Docker

- This is my attempt to make a Virtualised Desktop which is having a limited and controlled access to main system, while still be able to be light on resources compared to KVM
- It uses Debian:testing as base Image and installs VS-Code, Firefox and upwork, so that I can quickly build Image and start development in a containerized environment.
- It uses the [x11docker](https://github.com/mviereck/x11docker), which create a sandbox X11 environment and focuses on security
    - Now you ask, why not [distrobox](https://github.com/89luca89/distrobox)?, It's because it has tight integration with host, and It does not have sandbox feature yet,it's in WIP though => [Link](https://github.com/89luca89/distrobox/issues/28)

Note : After researching about rootless container, I found it more better approach, so now the build.sh will try to go with podman which is preferred for rootless container (docker can do rootless too).

# Install

- Install ```x11docker```, ```docker``` and ```aria2c``` first
- After that,clone this repo
```sh
git clone https://github.com/coolnsx/desktop-in-docker
cd desktop-in-docker
chmod +x build.sh
./build.sh "<your_image_name>" #passing nothing will use 'coolans' as imagename
```

- Above instruction will build an Image named coolans:latest
- Build.sh recommends rootless containers so it would defaults to podman, but if you use docker then it will shift to that.
- Then after that use this command, to run virtualized desktop (keep in mind, some of the args passed here with x11docker are not recommended and are against the philosophy of x11docker, as some of them degrades container Isolation, read more about it on x11docker readme)

```sh
#for docker(can be run with rootless docker too)
setsid -f x11docker $@ --desktop -g --xwayland --size '1920x1080' --shell=/bin/zsh -c -I --lang=$LANG --home="$HOME/x11docker" --limit='1.0' --dbus=system -- --cap-add=SYS_ADMIN --cap-add=SYS_CHROOT -- coolans #replace 'coolans', if you set the image name

#for podman with rootless
setsid -f x11docker $@ --backend=podman --rootless --runtime=crun --shell=/bin/zsh --lang=$LANG --desktop -g --xwayland --size '1920x1080' -c -I --home="$HOME/x11docker" --limit='1.0' --dbus=system -- --cap-add=SYS_CHROOT -- coolans #replace 'coolans', if you set the image name
```

- All the x11docker arguments are explained in x11docker repo's readme, please give it a good reading to start abusing x11docker :)
- Going with command is best if you want to use Electron apps without root

## Using Alternate method

- Recently I have Figured out how x11docker works, so I have taken inspiration from it and wrote my own script 

```sh
#!/bin/sh

#this sets the port which makes the Xwayland run on other DISPLAY=:$port, you can change it to any number
port="1"

#runs the Xwayland with some extension to help run the virtual desktop better
Xwayland :$port -ac +extension RANDR \
  +extension RENDER \
  +extension GLX \
  +extension XVideo \
  +extension DOUBLE-BUFFER \
  +extension SECURITY \
  +extension DAMAGE \
  +extension X-Resource \
  +extension Composite +extension COMPOSITE \
  -dpms -s off & >/dev/null

# note the PID to make sure the Xwayland is killed after the docker container is stopped
PID=$!

trap "kill $PID" INT HUP

#main docker command
docker run --rm --net=host -e DISPLAY=:$port -e LANG=$LANG -e container=podman -e HOME=$HOME -e SHELL=$SHELL -e USER=$USER -v $HOME/x11docker:/home/tanveer -v /usr/share/fonts/TTF:/usr/share/fonts/TTF -v /tmp/.X11-unix/X$port:/tmp/.X11-unix/X$port -e XSOCKET=/tmp/.X11-unix/X$port --name coolans_docker coolans

#just for cleanup
kill $PID
```
