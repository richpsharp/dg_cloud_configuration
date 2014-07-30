<?php

$file = "hostname.json";
$json = file_get_contents($file);
$hosts = json_decode($json);
$mac = $_GET["mac"];

if(property_exists($hosts, $mac))
{
echo $hosts->{$mac};
}
else
{
$hosts->{"count"} = $hosts->{"count"} + 1;
$hosts->{$mac} = "ncp-eg" . $hosts->{"count"};

file_put_contents($file, json_encode($hosts));
echo $hosts->{$mac};
}

?>
