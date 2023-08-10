#!/bin/sh

#This is an init.sh file that has all the commands to build the container I want

apt update
apt-mark hold iptables
DEBIAN_FRONTEND=noninteractive apt upgrade -y --no-install-recommends \
	dbus-x11 \
	libvulkan1 \
	xdg-utils \
	btop \
	gpg \
	gpg-agent \
	x11-xserver-utils \
	ca-certificates \
	libcurl3-gnutls \
	libsecret-1-0 \
	libu2f-udev \
	x11-utils \
	firefox-esr \
	libxss1 \
	libgdk-pixbuf2.0-0 \
	xfce4 \
	aria2 \
	xfce4-screenshooter \
	xfce4-whiskermenu-plugin \
	fonts-roboto \
	git \
	neovim \
	neofetch \
	openssh-client \
	xfce4-terminal \
	curl \
	libxv1 \
	mesa-utils \
	mesa-utils-extra && \
	apt install -y materia-gtk-theme papirus-icon-theme && \
	sed -i 's%<property name="ThemeName" type="string" value="Xfce"/>%<property name="ThemeName" type="string" value="Raleigh"/>%' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

#install upwork and code
[ -f "/tmp/upwork.deb" ] && apt install "/tmp/upwork.deb" -y
[ -f "/tmp/code.deb" ] && apt install "/tmp/code.deb" -y

exit 0
