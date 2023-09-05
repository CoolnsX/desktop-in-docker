###############DOCKERFILE##################
FROM debian:unstable

# Install Xvfb and XFCE desktop environment
COPY init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/init.sh

COPY *.deb /tmp/

RUN init.sh

CMD ["startxfce4"]
###########################################

