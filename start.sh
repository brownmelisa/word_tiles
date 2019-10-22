#!/bin/bash

export MIX_ENV=prod
export PORT=4795

echo "Starting app..."

# Start to run in background from shell.
#_build/prod/rel/memory/bin/memory start

# Foreground for testing and for systemd change this.

_build/prod/rel/word_tiles/bin/word_tiles start
# TODO: Add a systemd service file
#       to start your app on system boot.

