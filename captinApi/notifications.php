<?php
include "connection.php";

if(isset($_GET['insert'])){
    $acc_id = filter('acc_id');
    $title = filter('title');
    $body = filter('body');
    $date = filter('date');
    $time = filter('time');
    
    $stmt = $connect->prepare("INSERT INTO `notifications` VALUES(NULL,:id,:ti,:bd,:da,:tm)");
    $stmt->execute(array(
        'id'=>$acc_id,
        'ti'=>$title,
        'bd'=>$body,
        'da'=>$date,
        'tm'=>$time
    ));
    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array('status'=>1));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}
else if(isset($_GET['fetch'])){
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare("SELECT * FROM `notifications` WHERE `acc_id` = ?");
    $stmt->execute(array($acc_id));
    $notify = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        echo json_encode(array('status'=>1,'data'=>$notify));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}

?>