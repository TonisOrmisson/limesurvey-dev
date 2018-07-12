<?php

include_once 'vendor/autoload.php';

$url = "http://localhost/index.php?r=admin/remotecontrol";

// instantiate a new client
$client = new \org\jsonrpcphp\JsonRPCClient($url);
$sessionKey= $client->get_session_key('admin', 'password');

$file = __DIR__ . "/html/tests/data/surveys/limesurvey_survey_88881.lss";
$base64 = base64_encode(file_get_contents($file));
$result = $client->import_survey($sessionKey, $base64, 'lss', 'test-survey', 111111);
var_dump($result);
// release the session key
$client->release_session_key( $sessionKey );