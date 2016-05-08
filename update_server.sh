#!/bin/sh

SETUP_DIRECTORY="$( cd "$( dirname "$0" )" && pwd )"
USER=factorio
SERVER_DIR=factorio
TARBALL_NAME=factorio.tar.gz
HEADLESS_HOMEPAGE=https://www.factorio.com/download-headless/stable

service factorio stop

su factorio
cd $HOME
rm -R $SERVER_DIR

$SETUP_DIRECTORY/parse_headless.py $HEADLESS_HOMEPAGE | wget -i - -O $TARBALL_NAME
tar -xzf $TARBALL_NAME

ln -s /home/$USER/Dropbox/factorio /home/$USER/$SERVER_DIR/saves
NEWEST_SAVE=$( ls -t /home/$USER/Dropbox/factorio | head -n 1 )

timeout 5 "$SERVER_DIR/bin/x64/factorio --start-server $NEWEST_SAVE"

service factorio start
