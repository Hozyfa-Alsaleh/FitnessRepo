<?php

include "connection.php";


if(isset($_GET['insert'])){
    $details = filter('details');
    $day_id = filter('day_id');
    $acc_id = filter('acc_id');
    $name = filter('name');
    $stmt = $connect->prepare("INSERT INTO `exercises` VALUES (:id,:det,:d,:acc)");
    $stmt->execute(array('id'=>NULL,'det'=>$details,'d'=>$day_id,'acc'=>$acc_id));
    $count = $stmt->rowCount();
    if($count > 0)
    {
        $fetch = $connect->prepare("SELECT * FROM `exercises` WHERE `acc_id` = ?");
        $fetch->execute(array($acc_id));
        $exes = $fetch->fetchAll(PDO::FETCH_ASSOC);
        
        $arr = array('status' => 'exercise added','data'=>$exes);
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 'Faild to add exercise');
        echo json_encode($arr);
    }
}
else if(isset($_GET['update'])){
    $details = filter('details');
    $day_id = filter('day_id');
    $acc_id = filter('acc_id');
    $name = filter('name');
    $stmt = $connect->prepare("UPDATE `exercises` SET `details` = ? , `day_id` = ? WHERE `acc_id` = ? ");
    $stmt->execute(array($details,$day_id,$acc_id));
    $count = $stmt->rowCount();   
    if($count > 0){
        sendGCM("تمارين","تم تحديث تمرين في اليوم رقم $day_id","$name$acc_id","","");
        $arr = array('status' => 'exercise updated');
        echo json_encode($arr);
    }
    else{
        $arr = array('status' => 'Faild to update exercise');
        echo json_encode($arr);
    } 
}
else if(isset($_GET['delete'])){
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare("DELETE FROM `exercises` WHERE `acc_id` = ?");
    $stmt->execute(array($acc_id));
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>'Exercise deleted');
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>'Faild to delete exercise');
        echo json_encode($arr);
    }
}
else if(isset($_GET['fetch'])){
    $acc_id = filter('acc_id');
    $day = filter('day_id');
    $stmt = $connect->prepare("SELECT * FROM `exercises` WHERE `acc_id` = ? AND `day_id` = ?");
    $stmt->execute(array($acc_id,$day));
    $exe = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1,'data'=>$exe);
       echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0);
        echo json_encode($arr);
    }
}
else if(isset($_GET['fetchExe'])){
    
    $exe = filter('exe_id');
    $stmt = $connect->prepare("SELECT `vid_id` ,videos.exe_id,details,day_id,acc_id,videourl FROM `exercises`,`videos` WHERE exercises.exe_id = ? AND videos.exe_id =exercises.exe_id");
    $stmt->execute(array($exe));
    $exe = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1,'data'=>$exe);
       echo json_encode($arr);
    }
    else{
        $arr = array('status' => 0);
        echo json_encode($arr);
    }
}

?>