<?php
include "../connection.php";

if(isset($_GET['insert'])){
    $name = filter('name');
    $time = filter('time');
    $price = filter('price');
    $details = filter('details');

    $stmt = $connect->prepare("INSERT INTO `package` VALUES (?,?,?,?,?)");
    $stmt->execute(array(NULL,$name,$time,$price,$details));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status' => 1,'Message'=>'تم إضافة الباقة بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0,'Message'=>'فشل في إضافة الباقة');
        echo json_encode($arr);
    }
}
else if(isset($_GET['update'])){
    $p_id = filter('package_id');
    $name = filter('name');
    $time = filter('time');
    $price = filter('price');
    $details = filter('details');

    $stmt = $connect->prepare("UPDATE `package` SET `name` = ? , `time` = ? , `price` = ? , `details` = ? WHERE `package_id` = ?");
    $stmt->execute(array($name,$time,$price,$details,$p_id));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status' => 1,'Message'=>'تم تحديث الباقة بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0,'Message'=>'فشل في تحديث الباقة');
        echo json_encode($arr);
    }

}
else if(isset($_GET['delete'])){
    $p_id = filter('package_id');

    $stmt = $connect->prepare("DELETE FROM `package` WHERE `package_id` = ?");
    $stmt->execute(array($p_id));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status' => 1,'Message'=>'تم حذف الباقة بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0,'Message'=>'فشل في حذف الباقة');
        echo json_encode($arr);
    }
}
else if(isset($_GET['fetch'])){
    $stmt = $connect->prepare('SELECT * FROM `package`');
    $stmt->execute();
    $packages =  $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1,'data'=>$packages);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0);
        echo json_encode($arr);
    }
}
else{
    echo json_encode('There is no GET request');
}