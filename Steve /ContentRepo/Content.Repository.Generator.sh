#!/bin/bash
# -*- ENCODING: UTF-8 -*-

_site=user.controller.cu
_multiSite=user_controller
#site conf
        _langcode=en
        _site_name=steveCMSclient
        _site_mail=contact@client1.dev
        _account_name=admin
        _account_mail=contact@client1.dev
        _account_pass=admin

    #Data Base Conf
        _type=mysql
        _host=localhost
        _name=$_multiSite 
        _user=root
        _pass=root
        _port=3316

    #Drupal console patch
     _data=$(pwd)
     _url=$_data/$_site/console/

#Create postgreSql db - pending 
    composer create-project drupal/drupal $_site
    cd $_site    
 
#synfony extentions
echo "---------------------------------"
echo "Synfony extentions - Dependencies"
echo "---------------------------------"
composer require drupal/console:~1.0    
composer require guzzlehttp/guzzle-services    
composer require cocur/slugify 

 echo "---------------------------------"
    echo "Cloning steve repositories"
    echo "---------------------------------"
        echo "Cloning steve-modules"
        echo "---------------------------------"    
            mkdir modules/contrib
            git clone git@bitbucket.org:rebelp/steve-modules.git modules/custom

        echo "---------------------------------"
        echo "Cloning steve-themes"
        echo "---------------------------------"
            mkdir themes/contrib
            git clone git@bitbucket.org:rebelp/steve-templates.git themes/custom
           


echo " We are done !!! Enjoy your new site. "
echo "---------------------------------"
echo "CREATE DATABASE -  $_name - IF NOT EXISTS"
echo "---------------------------------"


mysql -u $_user -p$_pass <<MY_QUERY
CREATE DATABASE IF NOT EXISTS $_multiSite
MY_QUERY

echo "---------------------------------"
echo "Start  -  Instalation and Configuration"
echo "---------------------------------"
cd sites/$_multiSite
drupal init --destination $_url --autocomplete
drupal  site:install standard --langcode="$_langcode" --db-type="$_type" --db-host="$_host" --db-name="$_name" --db-user="$_user" --db-pass="$_pass" --db-port="$_port" --db-prefix="stevecms_" --site-name="$_site_name" --site-mail="$_site_mail" --account-name="$_account_name" --account-mail="$_account_mail" --account-pass="$_account_pass" --force
drupal cr all
echo "---------------------------------"
    echo "Installing other core and contib modules "
    echo "---------------------------------"

        drush en media  --resolve-dependencies -y
        drush en admin_toolbar_tools  --resolve-dependencies -y
        drush en admin_toolbar_links_access_filter  --resolve-dependencies -y
        drush en devel  --resolve-dependencies -y
        drush en devel_generate  --resolve-dependencies -y
        drush en features  --resolve-dependencies -y
        drush en field_group  --resolve-dependencies -y
        drush en shortcode  --resolve-dependencies -y
        drush en pathauto  --resolve-dependencies -y
        drush en pathauto rebel_endpoints --resolve-dependencies -y
         
    echo "---------------------------------"
    echo "Instaling modules Requires"
    echo "---------------------------------"
        drush en rp_repo --resolve-dependencies -y
  
    echo "---------------------------------"
    echo "Instaling Themes and dependencies"
    echo "---------------------------------"
        #Enable default template    
        drush en $_admima_theme  --resolve-dependencies -y
        drush config-set system.theme admin $_admima_theme -y
        drush config-set system.theme default $_admima_theme -y 
        drush cache-rebuild all
    echo " We are done !!! Enjoy your new site. "
