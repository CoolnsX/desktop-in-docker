#!/bin/sh

#This is an init.sh file that has all the commands to build the container I want

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
	fonts-roboto \
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
	mesa-utils-extra \
	&& apt install -y zsh-static zsh-syntax-highlighting dbus-x11 x11-utils x11-xserver-utils materia-gtk-theme papirus-icon-theme \
	&& apt clean \
	&& apt purge systemd systemd-dev gstreamer1.0-plugins-base gstreamer1.0-gl -y \
	&& apt autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sS https://starship.rs/install.sh -o /tmp/install.sh \
	&& sh /tmp/install.sh -y \
	&& rm /tmp/install.sh \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen \
	&& echo "LANG=en_US.UTF-8" > /etc/locale.conf \
	&& apt install -y /tmp/*.deb \
	&& rm -rf /tmp/*.deb
