<?php
include "../connection.php";

if(isset($_GET['insert'])){
    $acc_id = filter('acc_id');
    $p_id = filter('package_id');
    $imgname = uploadImage('file','transimg/');
    if(uploadImage('file','transimg/') != 'exextenstion'){
        $stmt = $connect->prepare("INSERT INTO `subscribe` VALUES (?,?,?,?)");
        $stmt->execute(array(NULL,$acc_id,$p_id,$imgname));

        $count = $stmt->rowCount();
        if($count > 0){
            $stmt = $connect->prepare("UPDATE `accounts` SET `status` = '0' WHERE `acc_id`= ?");
            $stmt->execute(array($acc_id));
            echo json_encode(array('status' => 'تم الإشتراك'));
        }
        else{
            echo json_encode(array('status' => 'حصل خطأ أثناء الاشتراك'));
            
        }
    }
}


?>