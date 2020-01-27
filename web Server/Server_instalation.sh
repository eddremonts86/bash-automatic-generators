
#!/bin/bash
# -*- ENCODING: UTF-8 -*-
echo "---------------------------------"

echo "Server Instalation and configuration" 
echo "Repository Update & System Upgrading "
echo "---------------------------------"

        apt-get -y update
        apt-get -y upgrade 

echo "---------------------------------"
echo "install base app"
echo "---------------------------------"

          apt-get -y install git wget
          apt-get -y install \ apt-transport-https \ ca-certificates \ curl \ gnupg-agent \ software-properties-common        

echo "---------------------------------"
echo "Install Apache" 
echo "---------------------------------"

         apt-get -y  install apache2 \ apache2-utils

echo "---------------------------------"
echo "Install PHP"  
echo "---------------------------------"

         apt-get -y  install php libapache2-mod-php php-mysql php-cli mbstring php-mcrypt

echo "---------------------------------"
echo "Install Mysql"
echo "---------------------------------"

         apt-get -y  install mysql-server mysql-client

echo "---------------------------------"
echo "Install PhpMyadmin"
echo "---------------------------------"

         apt-get -y  install phpmyadmin php-mbstring php-gettext

echo "---------------------------------"
echo "Install Drupal and Frontend related"
echo "Drush"
echo "---------------------------------"

        wget https://github.com/drush-ops/drush/releases/download/8.3.1/drush.phar
        chmod +x drush.phar
        mv drush.phar /usr/local/bin/drush

echo "---------------------------------"
echo "Composer" 
echo "---------------------------------"

        wget https://getcomposer.org/download/1.6.5/composer.phar    
        chmod +x composer.phar
        mv composer.phar /usr/local/bin/composer

echo "---------------------------------"
echo "Drupal Console"
echo "---------------------------------"

        curl https://drupalconsole.com/installer -L -o drupal.phar
        chmod +x drupal.phar
        mv drupal.phar /usr/local/bin/drupal

echo "---------------------------------"
echo "Docker"
echo "---------------------------------"

        apt-get remove docker docker-engine docker.io containerd runc
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
        sudo apt-get -y update
        sudo apt-get -y install docker-ce docker-ce-cli containerd.io


echo "---------------------------------"
echo "Install Node JS" 
echo "---------------------------------"

         apt-get -y install nodejs 

echo "---------------------------------"
echo "npm"
echo "---------------------------------"

          apt-get -y install npm

echo "---------------------------------"
echo "NPM Pack"
echo "---------------------------------"

         npm install -g @vue/cli
         npm install -g gulp

echo "---------------------------------"
echo "Initial commands"
echo "---------------------------------"

        drush init   
        drupal init
        systemctl restart apache2
        docker run hello-world        

exit