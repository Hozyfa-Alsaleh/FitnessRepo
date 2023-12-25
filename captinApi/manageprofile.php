<?php


include "connection.php";

$acc_id = filter('acc_id');
$name = filter('name');
$lastname = filter('lastname');
$email = filter('email');
$pass = filter('password');
$phone = filter('phone');
$stmt = $connect->prepare("UPDATE `accounts` SET `name` = ? , `nickname`=? , `email` = ? ,`password` =? ,`phone` = ? WHERE `acc_id` = ?");
$stmt->execute(array($name,$lastname,$email,$pass,$phone,$acc_id));
$count = $stmt->rowCount();
if($count > 0 ){
    echo json_encode(array('status'=>1));

}
else{
    echo json_encode(array('status' => 0));
}



?>