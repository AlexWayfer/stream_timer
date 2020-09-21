#!/bin/sh

. `dirname "$0"`/../_common.sh

if [ ! -f ".node-version" ] || [ "$(cat .node-version)" != "$(node -v | tr -d 'v')" ]
then
	exe git -C ~/.nodenv/plugins/node-build pull

	if [ ! -f ".node-version" ]
	then
		echo "File '.node-version' not found. Installing last stable version..."
		latest_version=$(nodenv install -l | grep '^[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+$' | tail -1)
		exe nodenv install -s $latest_version
		exe nodenv local $latest_version
	else
		exe nodenv install -s
	fi
fi

exe npm install -g pnpm

exe nodenv rehash

exe pnpm install

exe pnpm run build
