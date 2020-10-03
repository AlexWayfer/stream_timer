#!/bin/sh

CURRENT_DIR=`dirname "$0"`

. $CURRENT_DIR/_common.sh

exe systemctl --user stop stream_timer

exe git checkout $1
exe git pull origin $1

exe $CURRENT_DIR/setup.sh "$@"

exe toys db migrate

exe systemctl --user start stream_timer
