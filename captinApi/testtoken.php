<?php

$notAuth = "";
include "connection.php";
// $acc_id = filter('acc_id');
// $stmt = $connect->prepare("SELECT `token` FROM `accounts` WHERE `acc_id`=?");
// $stmt->execute(array($acc_id));
// $token = $stmt->fetchAll(PDO::FETCH_ASSOC);
// $count = $stmt->rowCount();
// if($count > 0){
//     echo json_encode(array('status'=>1,'data'=>$token));
// }
// else{
//     echo json_encode(array('status'=>0));
// }
echo sendGCM("hi","test function","hozyfa","","");
//echo "Send";

?>