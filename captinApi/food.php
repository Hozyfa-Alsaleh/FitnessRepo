<?php
include "connection.php";

if(isset($_GET['insert'])){
    $acc_id = filter('acc_id');
    $meal = filter('meal');
    $stmt = $connect->prepare("INSERT INTO `food` VALUES(?,?,?)");
    $stmt->execute(array(NULL,$acc_id,$meal));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status' => 1,'Message'=>'تم إضافة كورس التغذية بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0,'Message'=>'فشل في إضافة كورس التغذية');
        echo json_encode($arr);
    }
}
else if(isset($_GET['update'])){
    $acc_id = filter('acc_id');
    $meal = filter('meal');
    $stmt = $connect->prepare("UPDATE `food` SET `meal` = ? WHERE `acc_id` = ?");

    $stmt->execute(array($meal,$acc_id));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status' =>1,'Message'=> 'تم تحديث كورس التغذية بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' =>0,'Message'=> 'فشل في تحديث كورس التغذية');
        echo json_encode($arr);
    }
}
else if(isset($_GET['delete'])){
    $acc_id = filter('acc_id');
   
    $stmt = $connect->prepare("DELETE FROM `food` WHERE `acc_id` = ?");

    $stmt->execute(array($acc_id));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1,'Message' => 'Food Deleted Successfuly');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0,'Message' => 'Faild to delete food');
        echo json_encode($arr);
    }
}
else if(isset($_GET['fetch'])){
    $acc_id = filter('acc_id');

    $stmt =$connect->prepare("SELECT * FROM `food` WHERE `acc_id` =?");
    $stmt->execute(array($acc_id));
    $food = $stmt->fetch(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1,'data'=>$food);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0);
        echo json_encode($arr);
    }
}
?>