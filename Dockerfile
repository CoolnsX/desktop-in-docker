###############DOCKERFILE##################
#base image
FROM debian:unstable

# Install XFCE desktop environment
COPY init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/init.sh

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
#extra packages you want to install like code,google-chrome, or any deb that is not in debian
COPY *.deb /tmp/

#installation script, installs and configures everything
RUN init.sh

#required if you want to show glyphs in terminals
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
ENV LANG=en_US.UTF-8

#main command whenever container starts up
CMD ["/bin/sh","/entrypoint.sh"]
###########################################

