<?php
include "connection.php";

if(isset($_GET['fetch'])){
    $stmt = $connect->prepare('SELECT * FROM `accounts` join `profilephoto` on `status` = 0 AND profilephoto.acc_id = accounts.acc_id');
    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1,'data'=>$users);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0);
        echo json_encode($arr);
    }
}
if(isset($_GET['fetchuser'])){
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare('SELECT * FROM information , subscribe , package WHERE subscribe.package_id = package.package_id and subscribe.acc_id =? and information.acc_id= ?');
    $stmt->execute(array($acc_id,$acc_id));
   $order =  $stmt->fetch(PDO::FETCH_ASSOC);
   $count = $stmt->rowCount();
   if($count > 0){
    $arr = array('status'=>1 , 'data'=>$order);
    echo json_encode($arr);
   }
   else{
    $arr = array('status'=>0);
    echo json_encode($arr);
   }
}
else if(isset($_GET['accept'])){
    $acc_id = filter('acc_id');
    $date = filter('date');
    $name = filter('name');
    $stmt = $connect->prepare('UPDATE accounts SET accounts.status = 1 , accounts.stopwatch = ? WHERE `acc_id` = ?');
    $stmt->execute(array($date,$acc_id));
    $count = $stmt->rowCount();
    
    if($count > 0){
        $deletS = $connect->prepare('DELETE FROM `subscribe` WHERE `acc_id` = ?');
        $deletS->execute(array($acc_id));
        sendGCM("إشعار الإشتراك","تم قبول طلبك سيقوم الكابتن شعيب بإضافة الكورسات اللازمة","$name$acc_id","","");
        echo json_encode(array('status'=>1));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}
else if(isset($_GET['reject'])){
    $acc_id = filter('acc_id');
    $name = filter('name');
    $stmt = $connect->prepare('DELETE FROM `subscribe` WHERE `acc_id` = ?');
    $stmt->execute(array($acc_id));
    $stmt = $connect->prepare('DELETE FROM `information` WHERE `acc_id` = ?');
    $stmt->execute(array($acc_id));
    $count = $stmt->rowCount();
    if($count > 0){
        sendGCM("إشعار الإشتراك","للأسف تم رفض طلبك ","$name$acc_id","","");
        echo json_encode(array('status'=>1));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}


?>