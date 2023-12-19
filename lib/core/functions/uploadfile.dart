import 'dart:convert';
import 'dart:io';

//import 'package:dartz/dartz_unsafe.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// Future<void> uploadeImage() async {
//   XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
//   File myfile = File(xfile!.path);
// }

postRequestWithFile(String url, Map data, File file) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  var length = await file.length();
  var stream = http.ByteStream(file.openRead());
  var res;
  var multipartFile =
      http.MultipartFile('file', stream, length, filename: basename(file.path));
  request.files.add(multipartFile);
  data.forEach((key, value) {
    request.fields[key] = value;
  });
  var myrequest = await request.send();

  var response = await http.Response.fromStream(myrequest);
  if (response.statusCode == 200) {
    res = jsonDecode(response.body);
    if (res['status'] == 'تم الإشتراك') {
      Get.offAllNamed(AppRoute.PlayerProfile);
    }
    // else {
    //   getxDialog('خطأ', ' ${res['status']}');
    // }
  } else {
    getxDialog('خطأ', 'رمز الخطأ: ${myrequest.statusCode}');
  }
  return response.reasonPhrase!;
}

postRequestWithListFile(String url, Map data, List<File> files) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));

  for (var file in files) {
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());

    var multipartFile = http.MultipartFile('file[]', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
  }

  data.forEach((key, value) {
    request.fields[key] = value;
  });
  var myrequest = await request.send();

  var response = await http.Response.fromStream(myrequest);
  print(response.body);
  if (response.statusCode == 200) {
    print('success');
  } else {
    print('faild');
  }
  var res = jsonDecode(response.body);
  return res['status'];
}
