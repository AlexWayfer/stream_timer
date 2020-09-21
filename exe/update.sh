#!/bin/sh

CURRENT_DIR=`dirname "$0"`

. $CURRENT_DIR/_common.sh

exe toys server stop

exe $CURRENT_DIR/setup.sh "$@"

exe toys server start
