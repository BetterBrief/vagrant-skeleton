<?php

//define DB settings
define('SS_DATABASE_SERVER', '127.0.0.1');
define('SS_DATABASE_CLASS','MySQLDatabase');
define('SS_DATABASE_TIMEZONE','+00:00');
define('SS_DATABASE_USERNAME', 'root');
define('SS_DATABASE_PASSWORD', '');
define('SS_DATABASE_NAME', 'vagrant');

//set the DB name - this provide backwards compatibility with 2.x and 3.0 sites
global $database;
$database = SS_DATABASE_NAME;

//define('SS_DATABASE_SUFFIX', '_dev');
define('SS_ENVIRONMENT_TYPE', 'dev');

define('SS_DEFAULT_ADMIN_USERNAME', 'admin');
define('SS_DEFAULT_ADMIN_PASSWORD', 'password');

global $_FILE_TO_URL_MAPPING;
$_FILE_TO_URL_MAPPING[__DIR__] = 'http://localhost';
