// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/handlingdata.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/models/package.dart';
import 'package:fitnessapp/models/player.dart';
import 'package:fitnessapp/models/playerdetails.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PlayersController extends GetxController {
  List<Player> player = [];
  List<PlayerDetails> playerdet = [];

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
        if (player.isEmpty) {
          for (var element in response['data']) {
            player.add(Player(
                id: element['acc_id'],
                name: element['name'],
                imgurl:
                    "${ApiLinks.profileFolder}/${element['imgUrl'].toString()}"));
          }
        }
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

  @override
  void onInit() {
    displayProfileImage();
    // displayProfile();
    super.onInit();
  }
}
