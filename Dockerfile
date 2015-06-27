#
# Dockerfile for Symfony application development
#



# Based on docker official ubuntu LTS image
FROM ubuntu:14.04



# Define Dockerfile maintainer
MAINTAINER Oliver THEBAULT <contact@oliver-thebault.com>



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

# Install NodeJS/NPM and globally install some dependencies (Bower, Gulp, etc.)
RUN \
  curl -sL https://deb.nodesource.com/setup | bash - && \
  apt-get install -y nodejs && \
  npm install -g npm && \
  npm install -g bower gulp grunt-cli



# Configure Nginx
COPY nginx/sites-enabled/default /etc/nginx/sites-enabled/default



# Allow www-data to use "sudo" to run commands "as root"
RUN \
  echo "www-data ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)



# Expose ports
EXPOSE 80 443



# Define mountable directories
VOLUME ["/var/www/html"]



# Define default working directory
WORKDIR /var/www/html



# Set the script to use as entry point for the container
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]



# Set the default 'docker run' command (will be use if no commands are explicitly passed by user)
CMD ["/bin/bash"]
