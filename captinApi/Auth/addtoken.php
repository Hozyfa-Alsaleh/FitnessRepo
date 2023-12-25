<?php

include "../connection.php";
$token = filter('token');
$acc_id = filter('acc_id');

$stmt = $connect->prepare("UPDATE `accounts` SET `token` = ? WHERE `acc_id` = ? AND `token` IS NULL");
$stmt->execute(array($token,$acc_id));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array('status'=>1));
}
else{
    echo json_encode(array('status'=>0));
}


?>