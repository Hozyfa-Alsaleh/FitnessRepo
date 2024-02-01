// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/core/StaticLData/staticvar.dart';
import 'package:captainshoaib/core/functions/getxdialog.dart';
import 'package:captainshoaib/models/package.dart';
import 'package:captainshoaib/models/player.dart';
import 'package:captainshoaib/models/playerdetails.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestsController extends GetxController {
  List<Player> players = [];
  PackageModel? package;
  int playerid = 0;
  String playername = "";
  List<PlayerDetails> playerInfo = [];
  String imagename = "";
  List<String> titles = [
    'الهدف من التمرين',
    "المنطقة",
    "القاعة",
    "العمر",
    "الطول",
    "الوزن",
    "ساعات النوم",
    "ساعات العمل",
    "ضغط العمل",
    "منذ متى يمارس اللعبة",
    "استخدام الهرمونات",
    "الإصابات",
    "أطعمة لايرغب بتناولها",

    ///fixed values
    ///uncompleted list
  ];
  String imagePath = "";

  Future getAllPlayers() async {
    ///
    ///Here will fetch the player who has status = 0
    ///
    var request = await http.post(Uri.parse(ApiLinks.fetchOrders), body: {});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      if (response['data'] != []) {
        if (players.isNotEmpty) {
          players.clear();
        }
        for (var element in response['data']) {
          players.add(Player(
              id: element['acc_id'],
              name: element['name'],
              imgurl: element['imgUrl'] != null
                  ? "${ApiLinks.profileFolder}/${element['imgUrl']}"
                  : ""));
        }
      }
    }
  }

  gotoRequestinfo(int index) {
    playerid = players[index].id!;
    playername = players[index].name!;
    Get.toNamed(AppRoute.requestInfo);
    update();
  }

  Future fetchUserInfo() async {
    ///
    ///Here we will get the details , package , pay image for player
    ///

    var request = await http.post(Uri.parse(ApiLinks.fetchUser),
        body: {'acc_id': playerid.toString()});
    var response = await jsonDecode(request.body);
    print(jsonDecode(request.body));

    if (response['status'] == 1) {
      if (playerInfo.isNotEmpty) {
        playerInfo.clear();
      }
      playerInfo.add(PlayerDetails(
          id: response['data']['acc_id'],
          courseState: "بانتظار الرد",
          area: response['data']['area'],
          hall: response['data']['hall'],
          height: response['data']['height'],
          target: response['data']['target'],
          weight: response['data']['weight'],
          sleephours: response['data']['sleephours'],
          workhours: response['data']['workhours'],
          workstress: response['data']['workstrees'],
          gamehistory: response['data']['gamehistory'],
          usehormon: response['data']['usehormon'],
          age: response['data']['age'],
          cannon: response['data']['cannon'],
          unlikedfood: response['data']['unlikedfood']));

      print("success");
    } else {
      print('faild');
    }
  }

  Future getSubscribeOfUser() async {
    var request = await http.post(Uri.parse(ApiLinks.fetchUser),
        body: {'acc_id': playerid.toString()});
    var response = await jsonDecode(request.body);

    if (response['status'] == 1) {
      if (response['data'] != null) {
        package = PackageModel(
            id: response['data']['id'],
            name: response['data']['name'],
            time: response['data']['time'],
            price: response['data']['price'],
            details: response['data']['details']);
        imagePath = "${ApiLinks.transFolder}/${response['data']['imgurl']}";
      }
      print(imagePath);
      print('success');
    } else {
      print('faild');
    }
  }

  Future<void> acceptplayer() async {
    ///
    ///Here we will accept the player them change his status to '1'
    ///and start the timer for his package
    ///
    var request = await http.post(Uri.parse(ApiLinks.acceptUser), body: {
      'acc_id': playerid.toString(),
      'date_enable': DateTime.now().toString(),
      'name': playername
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      getxDialog('', 'تم قبول اللاعب');
      Get.offAllNamed(AppRoute.captineHomePage);
    } else {
      getxDialog('خطأ', 'حدث خطأ ما');
    }

    ///Complete to accept order
  }

  Future<void> deletePlayer() async {
    ///
    ///Here the captin will refuse the player and drop him from data base
    ///
    var request = await http.post(Uri.parse(ApiLinks.rejectUser),
        body: {'acc_id': playerid.toString(), 'name': playername});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      getxDialog('', 'تم رفض الطلب');
    } else {
      getxDialog('', 'حدث خطأ ما');
    }
  }

  ///Display the profile photo
  Future displayProfileImage() async {
    //try {
    var request = await http.post(Uri.parse(ApiLinks.profileimg), body: {
      'acc_id': selectedUserId.toString(),
    });
    var response = await jsonDecode(request.body);
    print(response);
    if (response['status'] == 0) {
      return;
    } else {
      for (var element in response) {
        imagename = "${ApiLinks.profileFolder}/${element['imgUrl'].toString()}";
      }
    }
    update();
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
