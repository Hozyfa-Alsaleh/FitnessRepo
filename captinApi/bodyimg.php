<?php
include "connection.php";
if(isset($_GET['insert'])){
    $acc_id = filter('acc_id');
$count = count($_FILES['file']['name']);
uploadListOfFiles('file','body/');
for($i=0;$i<$count;$i++){
    $img = $_FILES['file']['name'][$i];
    $stmt = $connect->prepare("INSERT INTO `bodyimages` VALUES (NULL,'$acc_id','$img')");
    $stmt->execute();
}
    $replay = $stmt->rowCount();
    if($replay > 0){
        echo json_encode(array('status'=>1));
    }
    else{
        echo json_encode(array('status'=>0));
    }
}
else if(isset($_GET['update'])){
    $countFiles = count($_FILES['file']['name']);
   // $images = json_decode($_POST['old']);
    $acc_id = filter('acc_id');
    // for($i =0; $i < count($images); $i++){
    //     deleteFile('body/',$images[$i]);
        
    // }
     uploadListOfFiles('file','body/');
    //  $stmtDEL = $connect->prepare("DELETE FROM `bodyimages` WHERE `acc_id` = '$acc_id'");
    //  $stmtDEL->execute();
         
    for($i=0;$i<$countFiles;$i++){
        $img = $_FILES['file']['name'][$i];
         $stmt = $connect->prepare("INSERT INTO `bodyimages` VALUES (NULL,'$acc_id','$img')");
         $stmt->execute();
    }

    $count = $stmt->rowCount();
    if($count > 0)
    {

         sendGCM("تعديل المعلومات","قام المستخدم $name بإضافة صور جديدة","captine","","");
        echo json_encode(array("status" => 1));
    }
    else{
        echo json_encode(array("status" => 0));
    }
}
else if(isset($_GET['delete'])){
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare("DELETE FROM `bodyimages` WHERE `acc_id` = ?");
    $stmt->execute(array($acc_id));
    $count = $stmt->rowCount();
    if($count > 0){
        echo json_encode(array('status' => 1));
    }
    else{
        echo json_encode(array('status' => 0));
    }
}
else if(isset($_GET['fetch'])){
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare('SELECT * FROM `bodyimages` WHERE `acc_id`= ?');
    $stmt->execute(array($acc_id));
    $count = $stmt->rowCount();
    $imgs = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if($count > 0){
        echo json_encode(array('status'=>1 , 'data'=>$imgs));
    }
    else{
        echo json_encode(array('status'=>0));
    }
    
}



?>