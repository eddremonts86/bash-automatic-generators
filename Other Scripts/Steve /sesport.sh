#!/bin/bash
# -*- ENCODING: UTF-8 -*-


  echo "Instaling Themes and dependencies"
    drush en bootstrap --resolve-dependencies -y
    drush en rp_cms_steve_base_config --resolve-dependencies -y
    drush en rp_cms_steve_watchfooty_config --resolve-dependencies -y
    drush en stevethemebase --resolve-dependencies -y


 echo "Instaling modules Requires"
    drush en rp_repo --resolve-dependencies -y
    drush -y config-set rp_base.settings rp_base_site_api_id $_id_site
    drush rprepoapii site_info --query="filter[site][value]=$_id_site"  --update=1