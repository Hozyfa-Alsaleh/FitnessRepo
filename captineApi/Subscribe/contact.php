<?php
include "../connection.php";

if(isset($_GET['insert'])){
    $number = filter('phone');
    $imgname = uploadImage('file','barcodeimgs/');
    if(uploadImage('file','barcodeimgs/') != 'extenstion'){
        $stmt = $connect->prepare('INSERT INTO `contactinfo` VALUES (?,?,?)');
        $stmt->execute(array(NULL,$imgname,$number));

        $count = $stmt->rowCount();
        if($count > 0){
            echo json_encode(array('status'=>'تم إضافة المعلومات بنجاح'));
        }
        else{
            echo json_encode(array('status'=>'حصل خطأ أثناء إضافة المعلومات'));
        }
    }
}
else if(isset($_GET['update'])){
    $phone = filter('phone');
    $imgname = filter('barcodeimg');
    if(isset($_FILES['file'])){
        deleteFile("barcodeimgs/",$imgname);
       $imgname =  uploadImage('file','barcodeimgs/');
    }
    $stmt = $connect->prepare('UPDATE `contactinfo` SET `barcodeurl`=?,`phone`=?');
    $stmt->execute(array($imgname,$phone));
    $count = $stmt->rowCount();
    if($count > 0){
        echo json_encode(array('status'=>1));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}
else if(isset($_GET['fetch'])){
    $stmt = $connect->prepare('SELECT * FROM `contactinfo`');
    $stmt->execute();
    $contact = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=> 1,'data'=>$contact);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=> 0);
        echo json_encode($arr);
    }
}


?>