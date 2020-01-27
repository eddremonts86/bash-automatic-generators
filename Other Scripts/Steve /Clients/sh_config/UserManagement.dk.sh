#!/bin/bash
# -*- ENCODING: UTF-8 -*-

  echo "Drupal 8 Install"
  echo " -- To use this script you need --"
  echo " - PHP > 5.6 "
  echo " - Composer"
  echo " - Drupar Console"
  echo " - Drush > 8.0.12"

 ## Variable
    #system
        _systemUser=www
        _testnumber=UserManagement_dk_v2
    #apist
        _site=UserManagement.v2.dk                          #Folder name in the file system
        _id_site=13                                       	#API site id

    #site conf
        _langcode=en
        _site_name=UserManagement.dk
        _site_mail=user-management@gig.com
        _account_name=admin
        _account_mail=$_site_mail
        _account_pass=$_account_name

    #Data Base Conf
        _type=mysql
        _host=localhost
        _name=steve_$_testnumber
        _user=root
        _pass=root
       _port=3316
    #Drupal console patch
        _data=$(pwd)
        _url=$_data/$_site/console/
    #THEME
        _THEME=fortytwo_admin                                          #2
    #THEME CONFIGURATION
        _THEME_CONF=rp_cms_steve_integration_se_fodbald                #2

    #Repository branch
      #Modules
        _m_branch=develop
      #themes
        _t_branch=develop
      #Admin Theme
     #_admima_theme=material_admin
        _admima_theme=fortytwo_admin
