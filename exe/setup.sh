#!/bin/sh

CURRENT_DIR=`dirname "$0"`

. $CURRENT_DIR/_common.sh

exe $CURRENT_DIR/setup/ruby.sh

exe toys config check
# exe toys db create_user
# exe toys db create
# exe toys db migrate

exe $CURRENT_DIR/setup/node.sh
