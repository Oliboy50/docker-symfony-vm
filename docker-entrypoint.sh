#!/bin/bash
set -e

# Uncomment this to allow www-data to edit shared files
#usermod -G staff www-data

# Run services the container will use
sudo service php5-fpm start
sudo service nginx start

# Execute default Dockerfile CMD or user passed command
exec "$@"
