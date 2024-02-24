<?php

include "connection.php";

if(isset($_GET['insert'])){
    $ex_id = filter('exe_id');
    $details = filter('details');
    $day = filter('day_id');
    $acc_id = filter('acc_id');
    uploadListOfFiles('file','videos/');
    $countFiles = count($_FILES['file']['name']);
    for($i =0; $i < $countFiles; $i++){
        $filename = $_FILES['file']['name'][$i];
        $stmt = $connect->prepare('INSERT INTO `videos` VALUES (?,?,?)');
        $stmt->execute(array(NULL,$filename,$ex_id));
    }
        
        $count = $stmt->rowCount();
        if($count > 0){
            sendGCM("فيديوهات","تم إضافة $countFiles فيديوهات إلى التمرين \"$details\" ضمن اليوم رقم $day","user$acc_id","","");
            echo json_encode(array('status'=>'تم رفع الفيديوهات بنجاح'));
        }
        else{
            echo json_encode(array('status'=>'حصل خطأ أثناء رفع الفيديو'));
        }
    
}
else if(isset($_GET['update'])){
    $vid_id= filter('vid_id');
    $details = filter('details');
    $day = filter('day_id');
    $vidnumber = filter('vidnum');
    $acc_id = filter('acc_id');
    $videoname = uploadOneFile('file','videos/');
    $stmt = $connect->prepare('UPDATE `videos` SET `videourl` = ? WHERE `vid_id` = ?');
    $stmt->execute(array($videoname,$vid_id));
    $count = $stmt->rowCount();
    if($count > 0){
        sendGCM("تعديل فيديو","قام الكابتن بتعديل الفيديو رقم \"$vidnumber\" في التمرين \"$details\" ضمن اليوم رقم $day","user$acc_id","","");
        echo json_encode(array('status' => 1));
    }
    else{
        echo json_encode(array('status' => 0));
    }
}
else if(isset($_GET['delete'])){
    $vid_id = filter('vid_id');
    $details = filter('details');
    $day = filter('day_id');
    $vidnumber = filter('vidnum');
    $acc_id = filter('acc_id');
    $stmt = $connect->prepare('DELETE FROM `videos` WHERE `vid_id` = ?');
    $stmt->execute(array($vid_id));
    $count = $stmt->rowCount();
    if($count > 0){
        sendGCM("تعديل فيديو","قام الكابتن بحذف الفيديو رقم \"$vidnumber\" في التمرين \"$details\" ضمن اليوم رقم $day","user$acc_id","","");
        echo json_encode(array('status' => 1));
        
    }
    else{
        echo json_encode(array('status'=>0));
    }
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