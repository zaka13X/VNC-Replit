FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       xfce4 \
       tigervnc-standalone-server \
       tigervnc-common \
       tigervnc-tools \
       novnc \
       websockify \
       firefox-esr \
       dbus-x11 \
       x11-xserver-utils \
       docker.io \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.vnc \
    && printf '%s\n' '#!/bin/sh' 'unset SESSION_MANAGER' 'unset DBUS_SESSION_BUS_ADDRESS' 'exec startxfce4' > /root/.vnc/xstartup \
    && chmod +x /root/.vnc/xstartup

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 6080 5901
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
