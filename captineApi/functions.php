<?php

define('MB',1048576);


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


?>