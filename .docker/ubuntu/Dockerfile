FROM ubuntu:20.04

RUN apt-get update -y

# && apt-get upgrade -y

###########################################################################
# Install php
###########################################################################

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update

RUN apt install unzip
#RUN apt install -y php8.1-fpm
#RUN apt install -y php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-imap php8.1-mbstring php8.1-opcache php8.1-zip php8.1-intl
RUN apt install -y php8.1-fpm
RUN apt install -y php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-imap php8.1-mbstring php8.1-opcache php8.1-zip php8.1-intl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
###########################################################################
# Install nginx
###########################################################################

RUN apt install -y nginx

###########################################################################

# Install ffmpeg
###########################################################################
# RUN sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN apt-get update

###########################################################################

###########################################################################
# Install node & npm & nvm & pm2
###########################################################################

###########################################################################
# Install common util
###########################################################################

RUN apt-get install -y procps
RUN apt install -y cron
RUN apt install nano
RUN apt install curl
RUN apt install sudo

# php imagick
############################################################################

ENTRYPOINT ["/startup.sh"]
#CMD ["python3", "-m", "http.server", "4142"]
#CMD ['echo pwd']
CMD ["--verbose"]