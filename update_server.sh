#!/bin/sh

SETUP_DIRECTORY="$( cd "$( dirname "$0" )" && pwd )"
USER=factorio
SERVER_DIR=factorio
TARBALL_NAME=factorio.tar.gz
HEADLESS_HOMEPAGE=https://www.factorio.com/download-headless/stable

service factorio stop

su factorio <<'EOF'
cd $HOME
rm -R $SERVER_DIR

echo "downloading headless server..."
$SETUP_DIRECTORY/parse_headless.py $HEADLESS_HOMEPAGE | wget -i - -O $TARBALL_NAME
echo "extracting tarball..."
tar -xzf $TARBALL_NAME

echo "linking dropbox..."
ln -s /home/$USER/Dropbox/factorio /home/$USER/$SERVER_DIR/saves

NEWEST_SAVE=$( ls -t /home/$USER/Dropbox/factorio | head -n 1 )
echo "starting server with save $NEWEST_SAVE..."
timeout 5 "$SERVER_DIR/bin/x64/factorio --start-server $NEWEST_SAVE"
EOF

service factorio start
