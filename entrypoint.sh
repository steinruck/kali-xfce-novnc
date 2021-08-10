#!/bin/bash

# Start postgresql and add user for msfdb

service postgresql start
msfdb init > /dev/null 2>&1 & 

# Set password for VNC

mkdir -p /root/.vnc/
echo $VNCPWD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Start VNC server

if [ $VNCEXPOSE = 1 ]
then
  # Expose VNC
  vncserver :0 -rfbport $VNCPORT -geometry $VNCDISPLAY -depth $VNCDEPTH \
    > /var/log/vncserver.log 2>&1
else
  # Localhost only
  vncserver :0 -rfbport $VNCPORT -geometry $VNCDISPLAY -depth $VNCDEPTH -localhost \
    > /var/log/vncserver.log 2>&1
fi

/usr/share/novnc/utils/launch.sh --listen $NOVNCPORT --vnc localhost:$VNCPORT \
  > /var/log/novnc.log 2>&1 &

echo "Launch your web browser and open http://localhost:9020/vnc.html"

/bin/bash