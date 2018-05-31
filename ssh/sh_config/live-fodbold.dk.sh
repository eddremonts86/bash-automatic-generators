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
        _testnumber=_livefodbald
    #apist
        _site=livefodbald
        _id_site=13

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
        _name=steveBase$_testnumber
        _user=root
        _pass=root
        _port=3316

    #Drupal console patch
     _data=$(pwd)
     _url=$_data/$_site/console/

    #THEME
     _THEME=live_fodbald

    #THEME CONFIGURATION
     _THEME_CONF=rp_cms_steve_integration_live_fodbald

    #Repository branch
      #Modules
        _m_branch=develop
      #themes
        _t_branch=develop
      #Admin Theme
       #_admima_theme=material_admin
        _admima_theme=fortytwo_admin
