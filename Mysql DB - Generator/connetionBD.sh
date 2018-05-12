#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#Data Base Conf
        _type=mysql
        _host=localhost
        _bdname=edd
        _user=edd
        _pass=edd
        _port=3316
 
 #mysql -h $_host -u $_user -p$_pass <<CREATE DATABASE IF NOT EXISTS $_bdname 

mysql -u $_user -p$_pass <<MY_QUERY
CREATE DATABASE IF NOT EXISTS $_bdname
MY_QUERY