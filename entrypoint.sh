#!/bin/bash

cd /home/container

echo "================================="
echo " Container starting..."
echo "================================="

# Output optional debug
echo "Running on user: $(whoami)"

# Replace Startup Variables (Pterodactyl standard)
MODIFIED_STARTUP=$(eval echo "$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')")

echo ":/home/container$ ${MODIFIED_STARTUP}"

# Execute server
exec ${MODIFIED_STARTUP}
