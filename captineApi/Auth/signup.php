<?php
include "../connection.php";


$name = filter('name');
$nickname = filter('nickname');
$email = filter('email');
$pass = filter('password');
$phone = filter('phone');

if(checkemail($email,$connect) != true){
    $stmt = $connect->prepare("INSERT INTO `accounts` (`acc_id`,`name`,`nickname`,`email`,`password`,`phone`,`status`,`stopwatch`,`type`) VALUES (:id,:na,:nk,:em,:pas,:ph,:st,:sw,:ty)");
    $stmt->execute(array(
        'id'=>NULL,
        'na'=>$name,
        'nk'=>$nickname,
        'em'=>$email,
        'pas'=>$pass,
        'ph'=>$phone,
        'st'=>'2',
        'sw'=>NULL,
        'ty'=>'user'
    ));

    $count = $stmt->rowCount();
    if($count > 0){
        $arr= array('status'=>'Added successfully');
        echo json_encode($arr);
    }
    else{
        $arr= array('status'=>'Added Faild');
        echo json_encode($arr);
    }

}
else{
    $arr= array('status'=>'This user is already exist');
        echo json_encode($arr);
}