
#!/bin/bash

set -e

# Expecting blocks, logs, and summarks folders to be mounted to /noso_mount
echo "Checking for /nosomnt"
if [[ ! -d "/nosomnt" ]]; then
    echo "The /nosomnt dir doesn't exist, exiting"
    exit 1
fi

# Expecting wallet.pkw to be mounted to /nosowallet
echo "Checking for /nosowallet"
if [[ ! -d "/nosowallet" ]]; then
    echo "The /nosowallet dir doesn't exist, exiting"
    exit 1
fi

echo "Creating BLOCKS, SUMMARKS, and LOGS dirs if they don't exist"
mkdir -p /nosomnt/BLOCKS
mkdir -p /nosomnt/SUMMARKS
mkdir -p /nosomnt/LOGS

echo "Creating symbolic links for BLOCKS, SUMMARKS, and LOGS dirs from /app/NOSODATA to /nosomnt"
ln -s /nosomnt/BLOCKS /app/NOSODATA
ln -s /nosomnt/LOGS /app/NOSODATA/LOGS
ln -s /nosomnt/SUMMARKS /app/NOSODATA/SUMMARKS

echo "Copying wallet.pkw to NOSODATA dir"
cp /nosowallet/noso-mn-wallet /app/NOSODATA/wallet.pkw

echo "Creating symbolic links for log files"
touch /app/NOSODATA/errorlog.txt
ln -sf  /proc/1/fd/1 /app/NOSODATA/errorlog.txt

echo "Starting virtual frame buffer Xvfb"
Xvfb :99 -screen 0 640x480x8 -nolisten tcp &

# Small sleep to make sure Xvfb has time to come up
sleep 1

/app/Noso
