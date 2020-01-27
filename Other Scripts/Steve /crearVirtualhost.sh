#!/bin/bash
# -*- ENCODING: UTF-8 -*-

_dominio=steve.cu
_place=$(pwd)
_apachelog=${APACHE_LOG_DIR} 

echo "
<VirtualHost *:80>
   ServerName www.$_dominio
   ServerAlias $_dominio
   ServerAdmin webmaster@localhost
   DocumentRoot $_place/$_dominio
   ErrorLog $_place/logs/$_dominio.error.log
   CustomLog $_place/logs/$_dominio.access.log combined

   <Directory $_place>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
   </Directory>

</VirtualHost>
" >> $_dominio.conf
exit