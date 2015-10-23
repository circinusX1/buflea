<?php

    $ip="";
    if(isset($_GET['ip']) && strlen($_GET['ip'])>6)
        $ip=$_GET['ip'];
    if(isset($_POST['ip']) && strlen($_POST['ip'])>6)
        $ip=$_POST['ip'];


    $fp = @fsockopen("PR.OX.Y.IP", ACL_PORT, $errno, $errstr, 30);
    if($fp)
    {
    if($ip=="127.0.0.1")
    {
        //add ip ro ACL
        fwrite($fp, "A".$ip);
    }
    else
    {
        //remove ip from ACL
        fwrite($fp, "R".$ip);
    }
}
?>
