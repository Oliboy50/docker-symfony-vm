#
# Dockerfile for Symfony application development
#
# https://github.com/Oliboy50/docker-symfony-vm
#



# Based on docker official ubuntu LTS image
FROM ubuntu:14.04



# Define Dockerfile maintainer
MAINTAINER Oliver THEBAULT <contact@oliver-thebault.com>



# Update/upgrade apt-get
RUN \
	apt-get update && \
	apt-get -y upgrade



# Install Ubuntu miscellaneous packages
RUN \
  apt-get install -y \
    make \
    nano \
    vim \
    curl \
    git \
    wget

# Install Nginx
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  chown -R www-data:www-data /var/lib/nginx

# Install PHP and extensions
RUN \
  add-apt-repository -y ppa:ondrej/php5-5.6 && \
  apt-get update && \
  apt-get install -y --force-yes php5 php5-fpm php5-mysql php5-curl php-apc php5-xdebug

# Install Composer
RUN \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer

# Install Ruby
RUN \
  apt-get install -y ruby ruby-bundler && \
  gem install -n /usr/bin/ \
    sass \
    less \
    capistrano

# Install Python
RUN \
  apt-get update && \
  apt-get install -y python python-pip python-virtualenv

# Install NodeJS/NPM and globally install some dependencies (Nodemon, PM2, Bower, Gulp, etc.)
RUN \
  curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g \
    nodemon \
    pm2 \
    bower \
    gulp-cli \
    grunt-cli \
    mocha



# Clean apt-get (it's worth nothing)
RUN \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*



# Allow www-data to use "sudo" to run commands as "root" without password
RUN \
  echo "www-data ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)



# Make /var/www writable for bower install
RUN \
  chmod 777 /var/www



# Configure Nginx
COPY nginx/sites-enabled/default /etc/nginx/sites-enabled/default
COPY nginx/ssl/ /etc/nginx/ssl/



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
