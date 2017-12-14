<?php
$currency = "EUR";
if ($argc > 1)
  $currency = $argv[1];
$url = "https://api.coinbase.com/v2/prices/$currency/spot?";
$content = file_get_contents($url);
$array = json_decode($content, true);
$btc_price = $array['data']['0']['amount'];
//$btc_price = str_replace('.', ',', $btc_price);
$btc_price = substr($btc_price, 0, (strrpos($btc_price, ".")));
echo $btc_price;
?>
