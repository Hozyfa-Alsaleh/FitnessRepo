<?php

include "connection.php";

$stmt = $connect->prepare("SELECT * FROM `accounts`");
$stmt->execute();
$count = $stmt->rowCount();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
if($count >0){
    $arr = array('status'=>1,'data'=>$users);
    echo json_encode($arr);
}
else{
    $arr = array('status'=>0);
    echo json_encode($arr);
}
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS , GET");

?>