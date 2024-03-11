class ApiLinks {
  //----------------Servers

  static const String xamppServer = "http://10.0.2.2:80/xampp/captineApi/";
  static const String proteam = "https://captain.pro-team.pro/captineApi";
  static const String cinemanapro = "http://10.0.2.2:80/xampp/captineApi/";

  //-----------------Folders
  static const String video = "$proteam/videos";
  static const String contactFolder = "$proteam/Subscribe/barcodeimgs";
  static const String profileFolder = "$proteam/profile";
  static const String transFolder = "$proteam/Subscribe/transimg";
  //-----------------Pages
  static const String login = "$proteam/Auth/login.php";
  static const String signup = "$proteam/Auth/signup.php";
  static const String playerPhoto = "$xamppServer/info_user.php?photo";
  static const String fetchPlayerInfo = "$proteam/userinfo.php?fetch";
  static const String subscribe = "$proteam/Subscribe/subscribe.php?insert";
  static const String playersList = "$proteam/allusers.php?fetchAll";
  static const String deletePlayer = "$proteam/allusers.php?deleteUser";

  ///-------Exercises
  static const String addExercise = "$proteam/exercises.php?insert";
  static const String exerciseFetch = "$proteam/exercises.php?fetch";
  static const String exerciseUpdate = "$proteam/exercises.php?update";
  static const String exedelete = "$proteam/exercises.php?delete";

  ///--------Packages
  static const String packages = "$proteam/Subscribe/package.php?fetch";
  static const String packageInsert = "$proteam/Subscribe/package.php?insert";
  static const String packageUpdate = "$proteam/Subscribe/package.php?update";
  static const String packageDelete = "$proteam/Subscribe/package.php?delete";

  ///--------Food Links
  static const String foodInsert = "$proteam/food.php?insert";
  static const String foodDelete = "$proteam/food.php?delete";
  static const String foodFetch = "$proteam/food.php?fetch";
  static const String foodUpdate = "$proteam/food.php?update";

  ///-----Hormons Links
  static const String suppfetch = "$proteam/hormons.php?fetch";
  static const String suppInsert = "$proteam/hormons.php?insert";
  static const String suppUpdate = "$proteam/hormons.php?update";
  static const String suppDelete = "$proteam/hormons.php?delete";

  ///----Contact Links
  static const String contactfetch = "$proteam/Subscribe/contact.php?fetch";
  static const String contactInsert = "$proteam/Subscribe/contact.php?insert";
  static const String contactUpdate = "$proteam/Subscribe/contact.php?update";
  static const String contactDelete = "$proteam/Subscribe/contact.php?fetch";

  ///----Player Info
  static const String insertPlayerInfo = "$proteam/userinfo.php?insert";
  static const String updateinfo = "$proteam/userinfo.php?update";
  static const String bodyimgsfetch = "$proteam/bodyimg.php?fetch";
  static const String bodyimgsInsert = "$proteam/bodyimg.php?insert";
  static const String bodyimgsUpdate = "$proteam/bodyimg.php?update";

  ///------Videos
  static const String fetchVideos = "$proteam/videos.php?fetch";
  static const String insertVideos = "$proteam/videos.php?insert";
  static const String updateVideos = "$proteam/videos.php?update";
  static const String deleteVideos = "$proteam/videos.php?delete";

  ///------ORDERS
  static const String fetchOrders = "$proteam/orders.php?fetch";
  static const String fetchUser = "$proteam/orders.php?fetchuser";
  static const String acceptUser = "$proteam/orders.php?accept";
  static const String rejectUser = "$proteam/orders.php?reject";

  ///
  static const String profileimg = "$proteam/profileimg.php?fetch";
  static const String profileimgAll = "$proteam/profileimg.php?fetchAll";
  static const String fetchcurrentexe = "$proteam/exercises.php?fetchExe";
  static const String insertProfileImg = "$proteam/profileimg.php?insert";
  static const String updateProfileImg = "$proteam/profileimg.php?update";
  static const String fetchExeUser = "$proteam/exercises.php?fetch";
  static const String fetchfood = "$proteam/food.php?fetch";
  static const String deleteBodyImages = "$proteam/bodyimg.php?delete";
}
