<?php

include "connection.php";

if(isset($_GET['insert'])){
$id_user = filter('acc_id');
$image = uploadImage('file','profile/');
if(uploadImage('file' , 'profile/') != 'extenstion'){
    $stmt = $connect->prepare("INSERT INTO `profilephoto` VALUES (?,?,?)");
    $stmt->execute(array(NULL,$id_user,$image));

    $count = $stmt->rowCount();
    if($count > 0)
    {
        echo json_encode(array("status" => "تم رفع صورة البروفايل"));
    }
    else{
        echo json_encode(array("status" => "فشل في رفع صورة البروفايل"));
    }
}
else{
    echo json_encode(array('status' => 'لم تقم برفع صورة'));
}
}
else if (isset($_GET['update'])){
    $imgname = filter('imgUrl');
    $acc_id = filter('acc_id');
    deleteFile('profile/',$imgname);
    $imgname = uploadImage('file','profile/');
    if(uploadImage('file' , 'profile/') != 'extenstion'){
    $stmt = $connect->prepare("UPDATE `profilephoto` SET `imgUrl` = ? WHERE `acc_id` = ?");
    $stmt->execute(array($imgname,$acc_id));

    $count = $stmt->rowCount();
    if($count > 0)
    {
        echo json_encode(array("status" => "تم رفع صورة البروفايل"));
    }
    else{
        echo json_encode(array("status" => "فشل في رفع صورة البروفايل"));
    }
}
    

}
else if(isset($_GET['fetch'])){
    
      $id_user = filter('acc_id');
    $stmt = $connect->prepare('SELECT * FROM `profilephoto` WHERE `acc_id`=?');
    $stmt->execute(array($id_user));
    $count = $stmt->rowCount();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if($count > 0){
        $arr = array('status'=>1,'data'=>$data);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0);
        echo json_encode($arr);
    }
    
}
else if(isset($_GET['fetchAll'])){
    $stmt = $connect->prepare('SELECT `acc_id`,`name`,`imgUrl` FROM `profilephoto` , `accounts` WHERE `profilephoto.acc_id` = `accounts.acc_id`');
    $stmt->execute();
    $count = $stmt->rowCount();
    $imgs = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if($count > 0){
        $arr = array('status'=>1,'data'=>$imgs);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0);
        echo json_encode($arr);
    }
}


?>