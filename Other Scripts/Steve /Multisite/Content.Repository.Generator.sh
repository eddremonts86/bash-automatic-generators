#!/bin/bash
# -*- ENCODING: UTF-8 -*-

_site=user.controller.cu
_multiSite=user_controller
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
           


echo " We are done !!! Enjoy your new site."
 
drupal init --destination $_url --autocomplete 
exit
