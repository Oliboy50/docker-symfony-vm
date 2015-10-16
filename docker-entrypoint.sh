#!/bin/bash
set -e

# Run services the container will use
sudo service php5-fpm start
sudo service nginx start

# Execute default Dockerfile CMD or user passed command
exec "$@"
