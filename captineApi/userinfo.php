<?php
include "connection.php";



if(isset($_GET['insert'])){

    $acc_id = filter('acc_id');
    $weight = filter('weight');
    $height = filter('height');
    $age = filter('age');
    $hall = filter('hall');
    $area = filter('area');
    $sleephours = filter('sleephours');
    $workhours = filter('workhours');
    $workstrees = filter('workstrees');
    $gamehistory = filter('gamehistory');
    $target = filter('target');
    $usehormon = filter('usehormon');
    $cannon = filter('cannon');
    $unlikefood = filter('unlikedfood');

    $stmt = $connect->prepare("INSERT INTO `information` VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

    $stmt->execute(array(NULL,$acc_id,$weight,$height
    ,$age,$hall,$area,$sleephours,$workhours,$workstrees,$gamehistory,$target,
    $usehormon,$cannon,$unlikefood
));
$count = $stmt->rowCount();
if($count > 0){
    $arr = array('status'=> 'Informations added');
    echo json_encode($arr);
}
else{
    $arr = array('status'=> 'Faild to add informations');
    echo json_encode($arr);
}

}
else if(isset($_GET['update'])){
    $acc_id= filter('acc_id');
    $weight = filter('weight');
    $height = filter('height');
    $age = filter('age');
    $hall = filter('hall');
    $area = filter('area');
    $sleephours = filter('sleephours');
    $workhours = filter('workhours');
    $workstrees = filter('workstrees');
    $gamehistory = filter('gamehistory');
    $target = filter('target');
    $usehormon = filter('usehormon');
    $cannon = filter('cannon');
    $unlikefood = filter('unlikedfood');

    $stmt = $connect->prepare("UPDATE `information` SET `weight` = ? ,
    `height` = ? ,
    `age` = ? ,
    `hall` = ?,
    `area`= ?,
    `sleephours` = ? ,
    `workhours` = ?,
    `workstrees` = ?,
    `gamehistory` = ?,
    `target` = ?,
    `usehormon` = ?,
    `cannon` = ?,
    `unlikedfood` = ? 
    WHERE `acc_id` = ?");
    $stmt->execute(array($weight,$height,$age,$hall,$area,
    $sleephours,$workhours,$workstrees,$gamehistory,
    $target,$usehormon,$cannon,$unlikefood,$acc_id));
    $count = $stmt->rowCount();
    
    //////////////////////////////////////
    ///////////////////////////////////////
    
    
    if($count>0){
        $arr = array('status'=> 'Informations updated successfully');
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=> 'Faild to update info');
        echo json_encode($arr);
    }
}
else if(isset($_GET['fetch'])){
    $acc_id = filter('acc_id');

    $stmt = $connect->prepare("SELECT * FROM `information` WHERE `acc_id` = ?");
    $stmt->execute(array($acc_id));
    $info = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    if($count > 0){
        $arr = array('status'=>1 , 'data' => $info);
        echo json_encode($arr);
    }
    else{
        $arr = array('status'=>0,'data'=>'There are no data');
        echo json_encode($arr);
    }
}

?>