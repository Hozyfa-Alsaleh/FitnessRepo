<?php

include "connection.php";


$acc_id = filter('acc_id');
$count = count($_FILES['file']['name']);
uploadListOfFiles('file','test/');
for($i=0;$i<$count;$i++){
    $img = $_FILES['file']['name'][$i];
    $stmt = $connect->prepare("INSERT INTO `testlist` VALUES (NULL,'$img','$acc_id')");
    $stmt->execute();
}
    $replay = $stmt->rowCount();
    if($replay > 0){
        echo json_encode(array('status'=>1,'count'=>$count,'imgname'=>$imgname));
    }
    else{
        echo json_encode(array('status'=>0));
    }


?>