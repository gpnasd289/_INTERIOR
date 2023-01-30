#!/bin/sh

/etc/init.d/php8.1-fpm start

#crontab /etc/cron.d/schedule-cron
#/etc/init.d/cron start

#cd /var/www/html && php artisan migrate

# Load this to get nvm environment, other wise pm2 will gets error
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nginx -g 'daemon off;'