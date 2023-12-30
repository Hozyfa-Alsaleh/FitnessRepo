<?php
include "connection.php";
if(isset($_GET['insert'])){
    $acc_id = filter('acc_id');
    $supp = filter('supp');
    $name = filter('name');
    $stmt = $connect->prepare("INSERT INTO `supplements` VALUES (?,?,?)");
    $stmt->execute(array(NULL,$acc_id,$supp));
   $count =  $stmt->rowCount();
    if($count>0){
        sendGCM("مكملات","تم إضافة كورس المكملات","$name$acc_id","","");
        $arr = array('status'=>1,'Message'=>'تم إضافة كورس الهرمون بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0,'Message'=>'فشل في إضافة كورس الهرمون');
        echo json_encode($arr);
    }
}
else if(isset($_GET['update'])){
    $acc_id = filter('acc_id');
    $supp = filter('supp');
    $name = filter('name');
    
    $stmt = $connect->prepare("UPDATE `supplements` SET `supp` = ? WHERE `acc_id` = ?");
    $stmt->execute(array($supp,$acc_id));
   $count =  $stmt->rowCount();
    if($count>0){
        sendGCM("مكملات","تم تحديث كورس المكملات","$name$acc_id","","");
        $arr = array('status'=>1,'Message'=>'تم تحديث كورس الهرمون بنجاح');
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0,'Message'=>'فشل في تحديث كورس الهرمون');
        echo json_encode($arr);
    }
}
else if(isset($_GET['delete'])){
    $acc_id = filter('acc_id');

    $stmt = $connect->prepare("DELETE FROM `supplements` WHERE `acc_id` = ?");
    $stmt->execute(array($acc_id));
   $count =  $stmt->rowCount();
    if($count>0){
        $arr = array('status'=>1,'Message'=>'Hormons Deleted Successfuly');
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0,'Message'=>'Faild tp delete Hormons');
        echo json_encode($arr);
    }
}
else if(isset($_GET['fetch'])){
    $acc_id = filter('acc_id');

    $stmt = $connect->prepare("SELECT * FROM `supplements` WHERE `acc_id` = ?");
    $stmt->execute(array($acc_id));
   $count =  $stmt->rowCount();
   $supp = $stmt->fetch(PDO::FETCH_ASSOC);
    if($count>0){
        $arr = array('status'=>1,'data'=>$supp);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0,'data'=>$supp);
        echo json_encode($arr);
    }
}
else{
    echo json_encode("There is no GET request");
}


?>