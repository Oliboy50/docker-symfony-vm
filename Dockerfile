#
# Dockerfile for Symfony application development
#
# Do not use this in production!
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
  apt-get install -y --force-yes \
    build-essential \
    software-properties-common \
    python-software-properties \
    nano \
    vim \
    curl \
    libcurl4-openssl-dev \
    git \
    wget \
    tar

# Install Nginx
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  chown -R www-data:www-data /var/lib/nginx

# Install MySQL client
RUN \
  apt-get install -y mysql-client

# Install PHP, some extensions (and make CLI use the FPM configuration) and Composer
RUN \
  add-apt-repository -y ppa:ondrej/php5-5.6 && \
  apt-get update && \
  apt-get install -y --force-yes php5 php5-fpm php5-mysql php5-curl php5-xdebug php5-intl && \
  cd /etc/php5/cli && mv php.ini php.ini.old && ln -s /etc/php5/fpm/php.ini && mv conf.d conf.d.old && ln -s /etc/php5/fpm/conf.d && cd / && \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer

# Install NodeJS/NPM and globally install some packages (Nodemon, PM2, Bower, Gulp, etc.)
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

# Install Ruby 2.2.3 and globally install some packages (bundler, capistrano, sass, less)
RUN \
  apt-get install -y --force-yes \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm-dev \
    libcurl4-openssl-dev && \
  curl -O http://ftp.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz && \
  tar -zxvf ruby-2.2.3.tar.gz && \
  cd ruby-2.2.3 && ./configure --enable-shared && make && make install && \
  cd .. && rm -r ruby-2.2.3 ruby-2.2.3.tar.gz && \
  gem install -n /usr/bin/ \
    bundler \
    sass \
    less \
    capistrano



# Allow www-data to use "sudo" to run commands as "root" without password
RUN \
  echo "www-data ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)



# Make /var/www writable for bower install
RUN \
  chmod 777 /var/www



# Configure Nginx
COPY nginx/fastcgi_params /etc/nginx/fastcgi_params
COPY nginx/sites-enabled/default /etc/nginx/sites-enabled/default
COPY nginx/ssl/ /etc/nginx/ssl/



# Configure PHP
COPY php/php.ini /etc/php5/fpm/php.ini



# Expose ports
EXPOSE 80 443



# Define mountable directories (project sources and ssh keys if needed)
VOLUME ["/var/www/html", "/var/www/.ssh"]



# Define default working directory
WORKDIR /var/www/html



# Set the script to use as entry point for the container
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]



# Set the default 'docker run' command (will be use if no commands are explicitly passed by user)
CMD ["/bin/bash"]
