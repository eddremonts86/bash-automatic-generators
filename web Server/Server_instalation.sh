
#!/bin/bash
# -*- ENCODING: UTF-8 -*-
# --- Server Instalation and configuration 

# --- Actualizando Paquetes
        apt-get -y  update


# --- install base app
          apt-get -y   install git wget curl
         
# --- Install Apache 
         apt-get -y  install apache2
         apt-get -y  install apache2-utils

# --- Install PHP  
         apt-get -y  install php libapache2-mod-php php-mysql php-cli mbstring php-mcrypt

# --- Install Mysql
         apt-get -y  install mysql-server mysql-client

# --- Install PhpMyadmin
         apt-get -y  install phpmyadmin php-mbstring php-gettext

         systemctl restart apache2

# --- Install Drupal and Frontend related
  #--- Drush
        wget https://github.com/drush-ops/drush/releases/download/8.1.17/drush.phar
        chmod +x drush.phar
        mv drush.phar /usr/local/bin/drush

  #--- Composer 
        wget https://getcomposer.org/download/1.6.5/composer.phar    
        chmod +x composer.phar
        mv composer.phar /usr/local/bin/composer


  #--- Drupal Console
        curl https://drupalconsole.com/installer -L -o drupal.phar
        chmod +x drupal.phar
        mv drupal.phar /usr/local/bin/drupal


# --- Install Node JS 
         apt-get -y install nodejs 
  #--- npm
          apt-get -yinstall npm
  #--- gulp 
         npm install -g gulp 
 
        drush init   
        drupal init
