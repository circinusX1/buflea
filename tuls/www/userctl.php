<?php

$querystring = $_GET['ip'];
if(strlen($querystring))
{
    $qs=$querystring;
    $ipparts = explode(":", substr($querystring,1));
    $iponly = $ipparts[0];
    if(count($ipparts)>1)
    	$port=$ipparts[1];
    else
        $port=0;
    $ctry=@geoip_country_name_by_name($iponly);

    if(substr($querystring,0,1)=='R')
    {
        // IP was reomved from proxy clients
    }
    else
    {
        // IP was added from proxy clients
    }
}
?>


