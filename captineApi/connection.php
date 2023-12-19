<?php
$dbname = "u478952749_newcaptine";
$host = "localhost";
$user = "u478952749_captine";
$pass = "Captine@12345678";
$dsn = "mysql:host=$host;dbname=$dbname";

$options = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8");


try {
$connect = new PDO($dsn,$user,$pass,$options);

    $connect->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    include "functions.php";
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
    header("Access-Control-Allow-Methods: POST, OPTIONS , GET");
} catch (PDOException $th) {
    echo json_encode($th->getMessage());
}


?>
