#!/bin/sh

SETUP_DIRECTORY="$( cd "$( dirname "$0" )" && pwd )"
FAC_USER=factorio
SERVER_DIR=factorio
TARBALL_NAME=factorio.tar.gz
HEADLESS_HOMEPAGE=https://www.factorio.com/download-headless/stable

service factorio stop

rm -R /home/$FAC_USER/$SERVER_DIR

echo "downloading headless server..."
$SETUP_DIRECTORY/parse_headless.py $HEADLESS_HOMEPAGE | wget -i - -O - --no-check-certificate | tar xzf -
mv $SERVER_DIR /home/$FAC_USER/$SERVER_DIR

echo "linking dropbox..."
ln -s /home/$FAC_USER/Dropbox/factorio /home/$FAC_USER/$SERVER_DIR/saves

chown $FAC_USER:$FAC_USER -R /home/$FAC_USER/$SERVER_DIR

NEWEST_SAVE=$( ls -t /home/$FAC_USER/Dropbox/factorio | head -n 1 )
echo "starting server with save $NEWEST_SAVE..."
timeout 5 /home/$FAC_USER/$SERVER_DIR/bin/x64/factorio --start-server $NEWEST_SAVE

service factorio start
