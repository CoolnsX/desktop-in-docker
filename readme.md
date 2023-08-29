# Desktop In Docker

- This is my attempt to make a Virtualised Desktop which is having a limited and controlled access to main system, while still be able to be light on resources compared to KVM
- It uses Debian:testing as base Image and installs VS-Code, Firefox and upwork, so that I can quickly build Image and start development in a containerized environment.
- It uses the [x11docker](https://github.com/mviereck/x11docker), which create a sandbox X11 environment and focuses on security
    - Now you ask, why not [distrobox](https://github.com/89luca89/distrobox)?, It's because it has tight integration with host, and It does not have sandbox feature yet,it's in WIP though => [Link](https://github.com/89luca89/distrobox/issues/28)

# Install

- Install ```x11docker```, ```docker``` and ```aria2c``` first
- After that,clone this repo
```sh
git clone https://github.com/coolnsx/desktop-in-docker
cd desktop-in-docker
chmod +x build.sh
./build.sh
```

- Above instruction will build an Image named coolans:latest
- Then after that use this command, to run virtualized desktop
```sh
setsid -f x11docker $@ --desktop --size 1920x1080 -c -I --home="$HOME/x11docker" --user=tanveer --limit='0.0' --dbus coolans
```
- All the x11docker arguments are explained in x11docker repo's readme, please give it a good reading to start abusing x11docker :)
