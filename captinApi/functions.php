<?php

define('MB',1048576);
//define('serverkey','AAAA5JVK_2c:APA91bE4BaDGuNH8bBl086IJv_awyjfGdWSUdCeZr0OC4XCjaduzsmIfAcVBDeCGlgmo1mehCbYyeldYFmR93nm7f8IaEDs0xE9XQYVjfIGkHsgrWXg0hSp_oX4DW5MlkdUkhRlyD5jk');
$serverkey = "AAAA5JVK_2c:APA91bE4BaDGuNH8bBl086IJv_awyjfGdWSUdCeZr0OC4XCjaduzsmIfAcVBDeCGlgmo1mehCbYyeldYFmR93nm7f8IaEDs0xE9XQYVjfIGkHsgrWXg0hSp_oX4DW5MlkdUkhRlyD5jk";
function filter($request){
  return  htmlspecialchars(strip_tags($_POST[$request]));
}

function checkemail($email,$con){
$stmt = $con->prepare("SELECT email FROM `accounts` WHERE `email` = ?");
$stmt->execute(array($email));
$emails = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0){
    return true;
}
else{
    
    return false;
}

}

$msgError;
function uploadImage($request,$dir){
 
  $imgname = $_FILES[$request]['name'];
  $imgtemp = $_FILES[$request]['tmp_name'];
  $imgsize = $_FILES[$request]['size'];

  $allowExt = array('jpg','png','mp4');
  $strToArray = explode(".",$imgname);
  $ext = end($strToArray);
  $ext = strtolower($ext);
  if(!empty($imgname) && !in_array($ext,$allowExt)){
    $msgError[] = "Extenstion";
  }
  if(empty($msgError)){
    move_uploaded_file($imgtemp,$dir.$imgname);
    return $imgname;
  }
  else{
    return 'extenstion';
  }
}
function deleteFile($dir,$imgname){
    if(file_exists($dir."/".$imgname)){
        unlink($dir."/".$imgname);
    }
}
function uploadListOfFiles($request,$dir){
    $count = count($_FILES[$request]['name']);
    $allowExt = array('jpg','png','mp4');
    for($i =0; $i < $count ; $i++){
        
    $imgname = $_FILES[$request]['name'][$i];
    $imgtemp = $_FILES[$request]['tmp_name'][$i];
    $imgsize = $_FILES[$request]['size'][$i];

    
    $strToArray = explode(".",$imgname);
    $ext = end($strToArray);
    $ext = strtolower($ext);
    if(!empty($imgname) && !in_array($ext,$allowExt)){
        $msgError[] = "Extenstion";
    }
    if(empty($msgError)){
        move_uploaded_file($imgtemp,$dir.$imgname);
      
    }
    else{
        return 'extenstion';
    }
        
    }
}

function sendGCM($title, $message, $topic, $pageid, $pagename)
{


    $url = 'https://fcm.googleapis.com/fcm/send';

    $fields = array(
        "to" => '/topics/' . $topic,
        'priority' => 'high',
        'content_available' => true,

        'notification' => array(
            "body" =>  $message,
            "title" =>  $title,
            "click_action" => "FLUTTER_NOTIFICATION_CLICK",
            "sound" => "default"

        ),
        'data' => array(
            "title" => $title,
            "body" =>  $message,
        )

    );


    $fields = json_encode($fields);
    $headers = array(
        'Authorization: key= AAAA5JVK_2c:APA91bE4BaDGuNH8bBl086IJv_awyjfGdWSUdCeZr0OC4XCjaduzsmIfAcVBDeCGlgmo1mehCbYyeldYFmR93nm7f8IaEDs0xE9XQYVjfIGkHsgrWXg0hSp_oX4DW5MlkdUkhRlyD5jk',
        'Content-Type: application/json'
    );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);

    $result = curl_exec($ch);
    return $result;
    curl_close($ch);
}


?>