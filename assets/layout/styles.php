<?php
require_once('../php/config.php');
require_once(INC.'php/lessc.inc.php');

#var_dump(        lessc::ccompile('main.less', 'styles.css'));
if($e->mode == 'dev') {
    try {
        lessc::ccompile('main.less', 'styles.css');
    } catch (exception $ex) {
 
        exit('lessc fatal error:<br />'.$ex->getMessage());
    }
}

header('Location:/assets/layout/styles.css');


