<?php

$currentDir = dirname(__FILE__);

// simple .env parser so that we have have single point of truth in 3.x
$dotEnvLocation = $currentDir . '/.env';
if (file_exists($dotEnvLocation)) {
	$settings = parse_ini_file($dotEnvLocation);
	foreach ($settings as $key => $value) {
		// define the 3.x constant
		if (!defined($key)) {
			define($key, $value);
		}
	}
}

// If for some reason you've not got or decided to delete your `.env` use sensible defaults

//define DB settings
if (!defined('SS_DATABASE_SERVER')) {
	define('SS_DATABASE_SERVER', '127.0.0.1');
}
if (!defined('SS_DATABASE_CLASS')) {
	define('SS_DATABASE_CLASS','MySQLDatabase');
};
if (!defined('SS_DATABASE_TIMEZONE')) {
	define('SS_DATABASE_TIMEZONE', '+00:00');
}
if (!defined('SS_DATABASE_USERNAME')) {
	define('SS_DATABASE_USERNAME', 'root');
}
if (!defined('SS_DATABASE_PASSWORD')) {
	define('SS_DATABASE_PASSWORD', '');
}
if (!defined('SS_DATABASE_NAME')) {
	define('SS_DATABASE_NAME', 'vagrant');
}

//set the DB name - this provide backwards compatibility with 2.x and 3.0 sites
global $database;
$database = SS_DATABASE_NAME;

//if (!defined('SS_DATABASE_SUFFIX')) {
//	define('SS_DATABASE_SUFFIX', '_dev');
//}
if (!defined('SS_ENVIRONMENT_TYPE')) {
	define('SS_ENVIRONMENT_TYPE', 'dev');
}

if (!defined('SS_DEFAULT_ADMIN_USERNAME')) {
	define('SS_DEFAULT_ADMIN_USERNAME', 'admin');
}
if (!defined('SS_DEFAULT_ADMIN_PASSWORD')) {
	define('SS_DEFAULT_ADMIN_PASSWORD', 'password');
}


foreach (array('project/public', 'www', 'public_html', 'weroot', 'public', 'project') as $webrootDir) {
	if (file_exists($webrootPath = $currentDir . DIRECTORY_SEPARATOR . $webrootDir)) {
		global $_FILE_TO_URL_MAPPING;
		$_FILE_TO_URL_MAPPING[$webrootPath] = 'http://localhost';
		break;
	}
}
