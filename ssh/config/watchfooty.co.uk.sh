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
        _systemUser=edd
        _testnumber=_watchfooty
    #apist
        _site=watchfooty                                 #Folder name in the file system
        _id_site=13                                       #API site id

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
        _name=steve$_testnumber
        _user=root
        _pass=root
        _port=3316

    #Drupal console patch
        _data=$(pwd)
        _url=$_data/$_site/console/

    #THEME
        _base_THEME=stevethemebase                                     #0

    #THEME CONFIGURATION
        _THEME_CONF=rp_cms_steve_watchfooty_config                     #5

    #Repository branch
      #Modules
        _m_branch=develop
      #themes
        _t_branch=develop
      #Admin Theme
        _admima_theme=material_admin


. ./install.sh --source-only