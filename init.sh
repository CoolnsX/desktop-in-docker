#!/bin/sh

#This is an init.sh file that has all the commands to build the container I want

#firefox

apt update
DEBIAN_FRONTEND=noninteractive apt upgrade -y --no-install-recommends \
	at-spi2-core \
	libvulkan1 \
	xdg-utils \
	iputils-ping \
	btop \
	locales \
	gpg \
	gpg-agent \
	ca-certificates \
	libcurl3-gnutls \
	libsecret-1-0 \
	libu2f-udev \
	xclip \
	bat \
	fzf \
	firefox \
	xdotool \
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
	libappindicator3-1 \
	xfce4-terminal \
	curl \
	libxv1 \
	libva-drm2 \
	mesa-utils \
	mesa-utils-extra && \
	apt install -y zsh-static zsh-syntax-highlighting dbus-x11 x11-utils x11-xserver-utils materia-gtk-theme papirus-icon-theme && \
	sed -i 's%<property name="ThemeName" type="string" value="Xfce"/>%<property name="ThemeName" type="string" value="Raleigh"/>%' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* &&
	curl -sS https://starship.rs/install.sh -o /tmp/install.sh && sh /tmp/install.sh -y && rm /tmp/install.sh && apt install -y /tmp/*.deb && rm -rf /tmp/*.deb
