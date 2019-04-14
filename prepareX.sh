VIRTUALGL_VERSION=2.6.1
TURBOVNC_VERSION=2.2.1
LIBJPEG_VERSION=2.0.0
NOVNC_VERSION=1.0.0
WEBSOCKIFY_VERSION=0.8.0
CWD=$(pwd)
mkdir -p /opt

# TurboVNC + VirtualGL
cd /tmp
curl -fsSL -O https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb
curl -fsSL -O https://sourceforge.net/projects/libjpeg-turbo/files/${LIBJPEG_VERSION}/libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb
curl -fsSL -O https://sourceforge.net/projects/virtualgl/files/${VIRTUALGL_VERSION}/virtualgl_${VIRTUALGL_VERSION}_amd64.deb
dpkg -i *.deb
sed -i 's/$host:/unix:/g' /opt/TurboVNC/bin/vncserver
rm -f /tmp/*.deb

# noVNC
curl -fsSL https://github.com/novnc/noVNC/archive/v${NOVNC_VERSION}.tar.gz | tar -xzf - -C /opt 
curl -fsSL https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz | tar -xzf - -C /opt 
rm -rf /opt/noVNC
mv /opt/noVNC-${NOVNC_VERSION} /opt/noVNC
rm -rf /opt/websockify
mv /opt/websockify-${WEBSOCKIFY_VERSION} /opt/websockify
ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html
cd /opt/websockify
make  > /dev/null

cd ${CWD}

# X11
apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        vim.tiny \
        nano \
        libc6-dev \
        libglu1 \
        libsm6 \
        libxv1 \
        x11-xkb-utils \
        xauth \
        xfonts-base \
        xkb-data \
        openbox \
        xterm \
        xvfb \
        x11vnc \
        xtightvncviewer \
        mesa-utils \
        python-opengl \
    > /dev/null
    
cd ${CWD}

# Xvfb (仮想ディスプレイ)
apt-get -q -y install xvfb > /dev/null

# Web ブラウザ（Epiphany）
add-apt-repository ppa:gnome3-team/gnome3  > /dev/null
apt-get update > /dev/null
apt-get install epiphany-browser > /dev/null

# Ngrok
mkdir -p /content/.vnc
curl -fsSL -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
rm /opt/ngrok
unzip -d /opt ngrok-stable-linux-amd64.zip
rm ngrok-stable-linux-amd64.zip 
echo "web_addr: 4045" > /content/config.yml

