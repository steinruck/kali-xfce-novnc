FROM kalilinux/kali-rolling:latest

LABEL website="https://github.com/steinruck/kali-xfce-novnc"
LABEL description="Kali with XFCE GUI in browser using noVNC."

# Install kali packages

ARG KALI_METAPACKAGE=core
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install kali-linux-${KALI_METAPACKAGE}
RUN apt-get -y install kali-tools-top10
RUN apt-get clean

# Install kali desktop with novnc

ARG KALI_DESKTOP=xfce
RUN apt-get -y install kali-desktop-${KALI_DESKTOP}
RUN apt-get -y install tightvncserver dbus dbus-x11 novnc net-tools

ENV USER root

ENV VNCEXPOSE 1
ENV VNCPORT 5900
ENV VNCPWD password
ENV VNCDISPLAY 1920x1080
ENV VNCDEPTH 16

ENV NOVNCPORT 8080

# Install custom packages/services

RUN apt-get -y install nano
RUN apt-get -y install iputils-ping

# Entrypoint

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]