###############DOCKERFILE##################
FROM debian:testing

# Install Xvfb and XFCE desktop environment
COPY init.sh /usr/local/bin
COPY run.sh /usr/local/bin

RUN chmod +x /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/run.sh

COPY upwork.deb /tmp/upwork.deb
COPY code.deb /tmp/code.deb

RUN init.sh

CMD ["startxfce4"]
###########################################

