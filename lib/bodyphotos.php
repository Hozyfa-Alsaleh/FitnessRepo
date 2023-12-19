<?php 


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST , GET , PUT");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-type: application/json; charset=utf-8');

require_once("./function.php");
$con = conn();


if(isset($_GET['insert'])){
    $id_user = $_POST['id_user'];
    $imgname = json_decode($_POST['image']);
      $base64 =json_decode( $_POST['photo']);
      if($imgname != null){
          for ($i=0; $i < count($imgname); $i++) { 
              $q = "INSERT INTO `bodyimages` VALUES (NULL,'".$imgname[$i]."','$id_user')";
              $r = (mysqli_query($conn , $q) or die(mysqli_error($conn)));
          }
      }
      if($r){
  
          $arr = array("status"=>1);
  
          for ($i=0; $i < count($base64); $i++) { 
              file_put_contents('bodyimages\\'.$imgname[$i],base64_decode($base64[$i])); 
          }
          mysqli_close($conn);
          echo json_encode($arr);
  
      }else{
          $arr = array("status"=>0);
          echo $q;
          mysqli_close($conn);
          echo json_encode($arr);
      }
}
else if(isset($_GET['fetch'])){

    $id_user = $_POST['user_id'];

    $q = "SELECT `image` FROM `bodyimages` WHERE `user_id` = '$id_user'";

    $r = mysqli_query($con,$q);
    
    if($r){
        $arr = array();
        while($s = mysqli_fetch_assoc($r)){
            array_push($arr,$s);
        }
        $arr2 = array('data'=>$arr);
        mysqli_close($con);
        echo json_encode($arr2);
    }
    else{
        $arr2 = array('status'=>'no photos for user');
        mysqli_close($con);
        echo json_encode($arr2);
    }
}
else if(isset($_GET['update'])){
    $id_user = $_POST['id_user'];
    $imgname = json_decode($_POST['image']);
      $base64 =json_decode( $_POST['photo']);
      if($imgname != null){
          for ($i=0; $i < count($imgname); $i++) { 
            $q = "UPDATE `bodyimages` SET `image` = '".$imgname[$i]."' WHERE `user_id` = '$id_user'";
             // $q = "INSERT INTO `bodyimages` VALUES (NULL,'".$imgname[$i]."','$id_user')";
              $r = (mysqli_query($conn , $q) or die(mysqli_error($conn)));
          }
      }
      if($r){
  
          $arr = array("status"=>1);
  
          for ($i=0; $i < count($base64); $i++) { 
              file_put_contents('bodyimages\\'.$imgname[$i],base64_decode($base64[$i])); 
          }
          mysqli_close($conn);
          echo json_encode($arr);
  
      }else{
          $arr = array("status"=>0);
          echo $q;
          mysqli_close($conn);
          echo json_encode($arr);
      }
}

?>