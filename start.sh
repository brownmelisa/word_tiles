#!/bin/bash

export MIX_ENV=prod
export PORT=4795

echo "Starting app..."

source ./prod-env.sh


# Start to run in background from shell.

# Foreground for testing and for systemd change this.

_build/prod/rel/word_tiles/bin/word_tiles start
# TODO: Add a systemd service file
#       to start your app on system boot.
