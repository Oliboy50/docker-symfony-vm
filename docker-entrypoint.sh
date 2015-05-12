#!/bin/bash
set -e

# Run services the container will use
service php5-fpm start
service nginx start

# Execute default Dockerfile CMD or user passed command
exec "$@"
