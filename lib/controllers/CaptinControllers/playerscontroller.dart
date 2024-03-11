// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/core/StaticLData/staticvar.dart';
import 'package:captainshoaib/core/classes/requeststate.dart';
import 'package:captainshoaib/core/functions/getxdialog.dart';
import 'package:captainshoaib/core/functions/handlingdata.dart';
import 'package:captainshoaib/models/package.dart';
import 'package:captainshoaib/models/player.dart';
import 'package:captainshoaib/models/playerdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PlayersController extends GetxController {
  List<Player> player = [];
  List<PlayerDetails> playerdet = [];
  List<Player> allPlayers = [];
  late TextEditingController searchbar;
  String profilePic = "";
  String imagename = "";
  Future getAllPlayers() async {
    requestStatus = RequestStatus.loading;
    var response = await testData.getAllPlayersForCaptin(ApiLinks.playersList);
    requestStatus = handlingdata(response);
    print(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 1) {
        print(response);
        if (searchbar.text.isNotEmpty) return;
        if (player.isNotEmpty) {
          player.clear();
        }

        for (var element in response['data']) {
          player.add(Player(
              id: element['acc_id'],
              name: element['name'],
              imgurl:
                  "${ApiLinks.profileFolder}/${element['imgUrl'].toString()}"));
        }
        if (allPlayers.isNotEmpty) {
          allPlayers.clear();
        }
        allPlayers.addAll(player);
        return player;
      } else {
        return null;
      }
    } else if (requestStatus == RequestStatus.offline) {
      getxDialog("خطأ ", "لا يوجد اتصال في الانترنت");
      return null;
    } else {
      getxDialog('خطأ', 'حدث خطأ أثناء الاتصال بالسيرفر');
    }
  }

  ///Display the profile photo
  Future displayProfileImage() async {
    try {
      var request = await http.post(Uri.parse(ApiLinks.profileimg),
          body: {'acc_id': selectedUserId.toString()});
      var response = await jsonDecode(request.body);
      print(response);
      if (response['status'] == 0) {
        return;
      } else {
        for (var element in response['data']) {
          imagename =
              "${ApiLinks.profileFolder}/${element['imgUrl'].toString()}";
        }
      }
      update();
    } catch (e) {
      getxDialog('حالة الاتصال', 'يبدو انك فقدت الاتصال بالانترنت');
      print(e.toString());
    }
    print(imagename);
  }

  Future displayProfile() async {
    //try {
    var request = await http.post(Uri.parse(ApiLinks.profileimg),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    print(response);
    if (response['status'] == 0) {
      return;
    } else {
      for (var element in response['data']) {
        profilePic =
            "${ApiLinks.profileFolder}/${element['imgUrl'].toString()}";
      }
    }
    update();
    // } catch (e) {
    //   print(e.toString());
    // }
    print(imagename);
  }

  ///Get User information and display them in Player info screen
  Future getplayerdetails() async {
    // try {
    requestStatus = RequestStatus.loading;
    var request = await testData.getPlayerInfo(
        ApiLinks.fetchPlayerInfo, selectedUserId.toString());
    requestStatus = handlingdata(request);
    print(request);
    // print(request['data']['area']);
    // print(request['area']);

    if (RequestStatus.success == requestStatus) {
      if (request['status'] == 1) {
        if (playerdet.isNotEmpty) {
          playerdet.clear();
        }
        for (var element in request['data']) {
          playerdet.add(PlayerDetails(
              id: element['acc_id'],
              courseState: "بانتظار الرد",
              area: element['area'],
              hall: element['hall'],
              height: element['height'],
              target: element['target'],
              weight: element['weight'],
              sleephours: element['sleephours'],
              workhours: element['workhours'],
              workstress: element['workstrees'],
              gamehistory: element['gamehistory'],
              usehormon: element['usehormon'],
              age: element['age'],
              cannon: element['cannon'],
              unlikedfood: element['unlikedfood']));
        }

        return playerdet;
      } else {
        return null;
      }
    } else if (requestStatus == RequestStatus.offline) {
      getxDialog('حالة الاتصال', 'أنت غير متصل بالانترنت');
      return null;
    }
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  selectedUser(int id, String name) async {
    selectedUserId = id;
    selectedUserName = name;
    Get.toNamed(AppRoute.coachprofile_C);
    await displayProfileImage();
    update();
  }

  Future<void> deleteUser() async {
    var request = await http.post(Uri.parse(ApiLinks.deletePlayer),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      Get.offAllNamed(AppRoute.players_C);
    } else {
      getxDialog('حذف متدرب', 'حدث خطأ خلال إزالة المتدرب');
    }
  }

//Fetch Player Images
  List<String> bodyPaths = [];
  fetchBodyImages() async {
    var request = await http.post(
        Uri.parse("${ApiLinks.proteam}/bodyimg.php?fetch"),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    print(response);
    if (response['status'] == 1) {
      if (bodyPaths.isNotEmpty) {
        bodyPaths.clear();
      }
      for (var element in response['data']) {
        bodyPaths.add("${ApiLinks.proteam}/body/${element['imgUrl']}");
      }
      print('success');
    } else {
      print('faild');
    }
    //update();
  }

  ///
  ///Method for get all packages
  ///
  // List<PackageModel> packages = [];
  // Future getAllPackages() async {
  //   // try {
  //   requestStatus = RequestStatus.loading;
  //   var request = await testData.getpackages(ApiLinks.packages);
  //   requestStatus = handlingdata(request);

  //   if (requestStatus == RequestStatus.success) {
  //     if (request['status'] == 1) {
  //       if (packages.isNotEmpty) {
  //         packages.clear();
  //       }
  //       for (var element in request['data']) {
  //         packages.add(PackageModel(
  //             id: element['package_id'],
  //             name: element['name'],
  //             time: element['time'],
  //             price: element['price'],
  //             details: element['details']));
  //       }
  //     }
  //     return packages;
  //   } else if (requestStatus == RequestStatus.offline) {
  //     return getxDialog('', 'أنت غير متصل بالانترنت');
  //   } else {
  //     return [];
  //   }
  //   //update();

  //   // } catch (e) {
  //   //   print(e.toString());
  //   //   return [];
  //   // }
  // }
  PackageModel? package;
  Future getSubscribeOfUser() async {
    var request = await http.post(Uri.parse(ApiLinks.fetchUser),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);

    if (response['status'] == 1) {
      if (response['data'] != null) {
        package = PackageModel(
            id: response['data']['id'],
            name: response['data']['name'],
            time: response['data']['time'],
            price: response['data']['price'],
            details: response['data']['details']);
      }
      print('success');
    } else {
      print('faild');
    }
  }

  ///Search about the player
  void searchAboutPlayer(String value) {
    if (allPlayers.isNotEmpty) {
      allPlayers.clear();
    }
    if (value.isNotEmpty) {
      List<Player> filterdList =
          player.where((element) => element.name!.contains(value)).toList();
      allPlayers.addAll(filterdList.reversed);
    }

    update();
  }

  void clearSearchBar() {
    searchbar.clear();
    update();
  }

  @override
  void onInit() {
    searchbar = TextEditingController();
    displayProfileImage();
    // displayProfile();
    super.onInit();
  }
}
