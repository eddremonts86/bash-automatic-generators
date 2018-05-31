#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# --- importing site configuration

#_site_confg=live-fodbold.dk.sh
#_site_confg=livefodboldstreams.dk.sh
#_site_confg=sefodbod.dk.sh
_site_confg=sesport.dk.sh
#_site_confg=watchfooty.co.uk.sh

_urlconf=$(pwd)
. $_urlconf/sh_config/$_site_confg --source-only

## Drupal Instalation

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
 echo " We are done !!! Enjoy your new site. "

echo "---------------------------------"
echo "CREATE DATABASE -  $_name - IF NOT EXISTS"
echo "---------------------------------"

mysql -u $_user -p$_pass <<MY_QUERY
CREATE DATABASE IF NOT EXISTS $_name
MY_QUERY



    echo "---------------------------------"
    echo "Start  -  Instalation and Configuration"
    echo "---------------------------------"
    drupal init --destination $_url --autocomplete
    drupal site:install standard --langcode="$_langcode" --db-type="$_type" --db-host="$_host" --db-name="$_name" --db-user="$_user" --db-pass="$_pass" --db-port="$_port" --db-prefix="stevecms_" --site-name="$_site_name" --site-mail="$_site_mail" --account-name="$_account_name" --account-mail="$_account_mail" --account-pass="$_account_pass" --force
    
# Required Extensions    
  

    echo "---------------------------------"
    echo "Cloning steve repositories"
    echo "---------------------------------"
        echo "Cloning steve-modules"
        echo "---------------------------------"    
            mkdir modules/contrib
            git clone git@bitbucket.org:rebelp/steve-modules.git modules/custom
            cd modules/custom
            git checkout $_m_branch 
            cd ../../

        echo "---------------------------------"
        echo "Cloning steve-themes"
        echo "---------------------------------"
            mkdir themes/contrib
            git clone git@bitbucket.org:rebelp/steve-templates.git themes/custom
            cd themes/custom
            git checkout $_t_branch
            cd ../../
    
    echo "---------------------------------"
    echo "Instaling modules Requires - CORE"
    echo "---------------------------------"
        #drush en config_translation  --resolve-dependencies -y
        #drush en content_translation  --resolve-dependencies -y
        #drush en locale  --resolve-dependencies -y

    echo "---------------------------------"
    echo "Patch to Page Manager Module "
    echo "---------------------------------"
        drush dl page_manager -y
        wget https://www.drupal.org/files/issues/page_manager_variant_route_filter-2918564.patch  
        patch -p1 modules/contrib/page_manager/src/Routing/VariantRouteFilter.php   ./page_manager_variant_route_filter-2918564.patch
        drush en page_manager --resolve-dependencies -y
        rm  page_manager_variant_route_filter-2918564.patch
    
    echo "---------------------------------"
    echo "Installing other core and contib modules "
    echo "---------------------------------"

        drush en media  --resolve-dependencies -y
        drush en admin_toolbar_tools  --resolve-dependencies -y
        drush en admin_toolbar_links_access_filter  --resolve-dependencies -y
        drush en ctools_views  --resolve-dependencies -y
        drush en field_layout  --resolve-dependencies -y
        drush en layout_builder  --resolve-dependencies -y

        drush en devel  --resolve-dependencies -y
        drush en devel_generate  --resolve-dependencies -y
        drush en features  --resolve-dependencies -y
        #drush en features_ui  --resolve-dependencies -y
        drush en field_group  --resolve-dependencies -y
        drush en shortcode  --resolve-dependencies -y
        #drush en page_manager_ui  --resolve-dependencies -y
        drush en panelizer  --resolve-dependencies -y
        drush en panelizer_quickedit  --resolve-dependencies -y
        drush en pathauto  --resolve-dependencies -y

        drush en twig_blocks  --resolve-dependencies -y 
        drush en schema_metatag --resolve-dependencies -y 
        #drush en purge  --resolve-dependencies -y
        #drush en varnish_purge  --resolve-dependencies -y
        #drush en purge_purger_http  --resolve-dependencies -y
        #drush en purge_queuer_coretags  --resolve-dependencies -y
        #drush en purge_ui  --resolve-dependencies -y

    echo "---------------------------------"
    echo "Instaling modules Requires"
    echo "---------------------------------"
        drush en rp_repo --resolve-dependencies -y

        drush en rp_ad_block --resolve-dependencies -y
        drush en rp_cookie --resolve-dependencies -y
        drush en rp_style --resolve-dependencies -y
        drush en rp_layout --resolve-dependencies -y
        drush en rp_client_base --resolve-dependencies -y


        drush -y config-set rp_base.settings rp_base_site_api_id $_id_site
        drush rprepoapii site_info --query="filter[site][value]=$_id_site"  --update=1
    
        #Manual site configutation import example
        # drush -y config-set rp_base.settings rp_base_site_api_id 13
        # drush rprepoapii site_info --query="filter[site][value]=13"  --update=1
  
    echo "---------------------------------"
    echo "Instaling Themes and dependencies"
    echo "---------------------------------"
        #Default config
         drush en bootstrap --resolve-dependencies -y    
    #    drush en $_base_THEME  --resolve-dependencies -y   
    #    drush config-set system.theme default $_base_THEME -y 
    #    drush en $_base_THEME_CONF  --resolve-dependencies -y


        # Exp config
        drush en $_THEME  --resolve-dependencies -y   
        drush config-set system.theme default $_THEME -y 
        drush en $_THEME_CONF  --resolve-dependencies -y

        #Enable default template    
        drush en $_admima_theme  --resolve-dependencies -y
        drush config-set system.theme admin $_admima_theme -y
 
    echo "---------------------------------"
    echo "Changing permissions"
    echo "---------------------------------"
        cd ../
        sudo chown -R $_systemUser:www-data  $_site/*
        chmod 755 $_site/sites/default/settings.php
        chmod -R 777 $_site/sites/default/files    
        cd $_site
        drush cache-rebuild all

    echo "---------------------------------"
    echo "Importing Data from API"
    echo "---------------------------------"
        #Schedule import 
         #drush rp_importfromapi    
        #Cleaning Cache
        drush cache-rebuild all

    echo " We are done !!! Enjoy your new site. "
    exit

