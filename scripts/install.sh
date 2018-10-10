#!/bin/sh

PROJECT=listener
BIN_DIR=/usr/bin
LIB_DIR=/usr/lib/${PROJECT}
SERVICE=/lib/systemd/system

# Build the application
colcon build

# Make the directories
mkdir -p ${LIB_DIR}

# Install the application
cp -r install ${LIB_DIR}
cp launchers/listener ${BIN_DIR}
cp launchers/listener.service ${SERVICE}/

echo Configure launchers to be used in systemd service
sed -i 's/{{[ ]*libdir[ ]*}}/\/usr\/lib\/listener/g' ${BIN_DIR}/listener

echo Restart the daemon for good measure
systemctl daemon-reload

# Restart the service
systemctl restart listener

exit 0