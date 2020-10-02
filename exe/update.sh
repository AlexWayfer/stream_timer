#!/bin/sh

CURRENT_DIR=`dirname "$0"`

. $CURRENT_DIR/_common.sh

exe systemctl --user stop stream_assistant

exe $CURRENT_DIR/setup.sh "$@"

exe toys db migrate

exe systemctl --user start stream_assistant
