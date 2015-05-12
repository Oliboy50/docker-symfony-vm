#
# Dockerfile for SiR application
#
# Inspired by Dockerfile Project:
# https://dockerfile.github.io
#

# Based on docker official ubuntu image
FROM ubuntu:14.04




# Install Ubuntu miscellaneous packages
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y nano vim man curl git wget unzip htop && \
  rm -rf /var/lib/apt/lists/*

# Install Nginx
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx

# Install PHP and extensions
RUN \
  add-apt-repository -y ppa:ondrej/php5-5.6 && \
  apt-get update && \
  apt-get install -y --force-yes php5 php5-fpm php5-mysql php5-curl php-apc php5-xdebug && \
  rm -rf /var/lib/apt/lists/*

# Install Composer
RUN \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer

# Install Python
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN \
  apt-get update && \
  apt-get install -y ruby ruby-dev ruby-bundler && \
  rm -rf /var/lib/apt/lists/*

# Install NodeJS/NPM and globally install some dependances (Bower, Gulp, etc.)
RUN \
  curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
  apt-get install -y nodejs && \
  npm install -g npm && \
  npm install -g bower gulp grunt-cli




# Configure Nginx
COPY nginx/sites-enabled/default /etc/nginx/sites-enabled/default




# Define mountable directories
VOLUME ["/var/www/html"]




# Expose ports
EXPOSE 80 443




# Set the script to use as entrypoint for the container
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]




# Set the default 'docker run' command (will be use if no commands are explicitely passed by user)
CMD ["/bin/bash"]
