<?php

include "connection.php";

if(isset($_GET['insert'])){
    $ex_id = filter('exe_id');
    $name = filter('name');
    uploadListOfFiles('file','videos/');
    $countFiles = count($_FILES['file']['name']);
    for($i =0; $i < $countFiles; $i++){
        $filename = $_FILES['file']['name'][$i];
        $stmt = $connect->prepare('INSERT INTO `videos` VALUES (?,?,?)');
        $stmt->execute(array(NULL,$filename,$ex_id));
    }
        
        $count = $stmt->rowCount();
        if($count > 0){
            sendGCM("تمارين","\"\"تم إضافة تمرين جديد","$name$acc_id","","");
            echo json_encode(array('status'=>'تم رفع الفيديوهات بنجاح'));
        }
        else{
            echo json_encode(array('status'=>'حصل خطأ أثناء رفع الفيديو'));
        }
    
}
else if(isset($_GET['update'])){
    $ex_id = filter('exe_id');
    
    $stmt = $connect->prepare('UPDATE `videos` SET `videourl` = ');
}
else if(isset($_GET['fetch']))
{
    $ex_id = filter('exe_id');
    $topic = filter('topic');
    $stmt = $connect->prepare('SELECT * FROM `videos` WHERE `exe_id` = ?');
    $stmt->execute(array($ex_id));
    $count = $stmt->rowCount();
    $videos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if($count > 0){
        $arr = array('status'=>1,'data'=>$videos);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0);
        echo json_encode($arr);
    }
}


?>