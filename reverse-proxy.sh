#!/bin/sh

# Start tinyproxy:
tinyproxy -d &

# Execute the given command:
exec "$@"
