# Kali Linux Docker Container with XFCE Desktop over VNC / noVNC

Kali Linux Docker container with full GUI. It uses the tightvncserver for VNC connection to the container and novnc for browser VNC access.

**IMPORTANT:** This image is for testing purposes only. Do not run it on any production systems or for any productive purposes. Feel free to modify it as you like – build instructions are given below.

## 1) Pull

First, pull the image:

```
docker pull steinruck/kali-xfce-novnc
```

## 2) Run

Start a new container from the image. Access the Kali Desktop at `http://localhost:9020/vnc.html`.

```
docker run --rm -it -p 9020:8080 -p 9021:5900 steinruck/kali-xfce-novnc
```

The default configuration is set as follows. Feel free to change this as required.

- `-e VNCEXPOSE=1`
  - By default, the VNC server is exposed. Use your VNC client of choice and connect to `localhost:9020` with the default password `password`. Can also access using IP:PORT.
  - Use `-e VNCEXPOSE=0` to only allow localhost access
  - The default port mapping for the VNC server is configured with the `-p 9021:5900` parameter.
- `-e VNCPORT=5900`
  - By default, the VNC server runs on port 5900 within the container.
  - Note: If you change this port, you also need to change the port mapping with the `-p 9021:5900` parameter.
- `-e VNCPWD=password`
  - Change the default password of the VNC server.
- `-e VNCDISPLAY=1920x1080`
  - Change the default display resolution of the VNC connection.
- `-e VNCDEPTH=16`
  - Change the default display depth of the VNC connection. Possible values are 8, 16, 24, and 32. Higher values mean better quality but more bandwidth requirements.
- `-e NOVNCPORT=8080`
  - By default, the noVNC server runs on port 8080 within the container.
  - Note: If you change this port, you also need to change the port mapping with the `-p 9020:8080` parameter.
- entrypoint.sh includes two commands to start postgresql and create and initialize the msf database with the msfdb command 

## Customization
XFCE Desktop is configured by default. 
You may also edit the `Dockerfile` or `entrypoint.sh` to install custom packages. 
You can specify different Kali Linux metapackages, i.e., `core`, `default`, `light`, `large`, `everything`, or `top10`. 
This image installs kali-tools-top10 and iputils-ping for basic Capture the Flag usage.
See [https://www.kali.org/news/major-metapackage-makeover/](https://www.kali.org/news/major-metapackage-makeover/) for more details and metapackages.

```
git clone https://github.com/steinruck/kali-xfce-novnc
cd kali-docker
docker build -t kaligui .
docker run --rm -it -p 9020:8080 -p 9021:5900 kaligui
```
