<?php

include "connection.php";

if(isset($_GET['fetchAll'])){
    $stmt = $connect->prepare("SELECT accounts.acc_id,`name`,`imgUrl` FROM `profilephoto` , `accounts` WHERE profilephoto.acc_id = accounts.acc_id AND accounts.status = 1 and `type`='user'");
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
}
else if(isset($_GET['deleteUser'])){
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare('DELETE FROM `accounts` WHERE `acc_id` = ?' );
    $stmt->execute(array($acc_id));
    $count = $stmt->rowCount();
    
    if($count > 0){
        echo json_encode(array('status'=>1));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}




?>