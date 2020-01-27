#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#Site
    _multiSite=v1_content.repository.sesport.cu
    _siteDB=v1_content_repository_sesport_cu
    _id_site=13
#THEME
        _base_THEME=stevethemebase                                   
    #THEME CONFIGURATION
        _base_THEME_CONF=rp_cms_steve_base_config                            
    #Admin Theme
         _admima_theme=fortytwo_admin


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
        _name=$_siteDB
        _user=root
        _pass=root
        _port=3316

mkdir sites/$_multiSite
cp sites/example.sites.php   sites/sites.php
cp sites/default/default.settings.php sites/$_multiSite/settings.php
echo "\$sites['$_multiSite'] = '$_multiSite';" >> sites/sites.php
drupal --uri=$_multiSite  site:install standard --langcode="$_langcode" --db-type="$_type" --db-host="$_host" --db-name="$_name" --db-user="$_user" --db-pass="$_pass" --db-port="$_port" --db-prefix="stevecms_" --site-name="$_site_name" --site-mail="$_site_mail" --account-name="$_account_name" --account-mail="$_account_mail" --account-pass="$_account_pass" --force
drupal --uri=$_multiSite  cr all

echo "---------------------------------"
    echo "Installing other core and contib modules "
    echo "---------------------------------"

        drush   --uri=$_multiSite  en  media  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  admin_toolbar_tools  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  admin_toolbar_links_access_filter  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  ctools_views  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  field_layout  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  layout_builder  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  devel  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  devel_generate  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  features  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  field_group  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  shortcode  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  panelizer  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  panelizer_quickedit  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  pathauto  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  twig_blocks  --resolve-dependencies -y
        drush   --uri=$_multiSite  en  schema_metatag --resolve-dependencies -y


    echo "---------------------------------"
    echo "Instaling modules Requires"
    echo "---------------------------------"
        drush   --uri=$_multiSite  en  rp_repo --resolve-dependencies -y
        drush   --uri=$_multiSite  en  rp_ad_block --resolve-dependencies -y
        drush   --uri=$_multiSite  en  rp_cookie --resolve-dependencies -y
        drush   --uri=$_multiSite  en  rp_style --resolve-dependencies -y
        drush   --uri=$_multiSite  en  rp_layout --resolve-dependencies -y
        drush   --uri=$_multiSite  en  rp_client_base --resolve-dependencies -y
        drush   --uri=$_multiSite  en  rebel_endpoints --resolve-dependencies -y
      
        #Manual site configutation import example
        # drush --uri=$_multiSite -y config-set rp_base.settings rp_base_site_api_id 13
        # drush --uri=$_multiSite rprepoapii site_info --query="filter[site][value]=13"  --update=1

    echo "---------------------------------"
    echo "Instaling Themes and dependencies"
    echo "---------------------------------"
        #Default config
         drush   --uri=$_multiSite  en  bootstrap --resolve-dependencies -y
    #    drush   --uri=$_multiSite  en  $_base_THEME  --resolve-dependencies -y
    #    drush   --uri=$_multiSite config-set system.theme default $_base_THEME -y
    #    drush   --uri=$_multiSite  en  $_base_THEME_CONF  --resolve-dependencies -y


        # Exp config
        drush   --uri=$_multiSite  en  $_base_THEME  --resolve-dependencies -y
        drush   --uri=$_multiSite config-set system.theme default $_THEME -y
        drush   --uri=$_multiSite  en  $_base_THEME_CONF  --resolve-dependencies -y

        #Enable default template
        drush   --uri=$_multiSite  en  $_admima_theme  --resolve-dependencies -y
        drush   --uri=$_multiSite  config-set system.theme admin $_admima_theme -y


        drush --uri=$_multiSite -y config-set rp_base.settings rp_base_site_api_id $_id_site
        drush --uri=$_multiSite rprepoapii site_info --query="filter[site][value]=$_id_site"  --update=1

        drush --uri=$_multiSite rp_importSitesByID $_id_site
        drush --uri=$_multiSite rp_importfromapi
        
        chmod -R 777 site/$_multiSite/files
        drush --uri=$_multiSite cr all 
exit
