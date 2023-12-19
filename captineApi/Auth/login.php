<?php
include "../connection.php";
$email = filter('email');
$pass = filter('password');

$stmt = $connect->prepare("SELECT * FROM `accounts` WHERE `email`=? AND `password` = ?");
$stmt->execute(array($email,$pass));
$user = $stmt->fetch(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0){
    $arr = array("status" => "success", 'data' => $user);
    echo json_encode($arr);
}
else{
    $arr = array("status" => "faild");
    echo json_encode($arr);
}
?>