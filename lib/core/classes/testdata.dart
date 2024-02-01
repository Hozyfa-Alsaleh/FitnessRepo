import 'package:captainshoaib/core/classes/crud.dart';

class TestData {
  CRUD crud;

  TestData(this.crud);

  getPlayerInfo(String url, String id) async {
    var response = await crud.postData(url, {'acc_id': id});
    return response.fold((l) => l, (r) => r);
  }

  login(String url, String email, String password) async {
    var response =
        await crud.postData(url, {'email': email, 'password': password});
    return response.fold((l) => l, (r) => r);
  }

  signup(String url, String firstName, String nickname, String email,
      String phone, String password) async {
    var response = await crud.postData(url, {
      'name': firstName,
      'nickname': nickname,
      'email': email,
      'password': password,
      'phone': phone
    });
    return response.fold((l) => l, (r) => r);
  }

  sendInfo(
      String url,
      String userid,
      String weight,
      String height,
      String age,
      String hall,
      String area,
      String sleephours,
      String workhours,
      String workstress,
      String gameHistory,
      String target,
      String useHormon,
      String cannon,
      String unLikeFood) async {
    var response = await crud.postData(url, {
      'acc_id': userid,
      'weight': weight,
      'height': height,
      'age': age,
      'hall': hall,
      'area': area,
      'sleephours': sleephours,
      'workhours': workhours,
      'workstrees': workstress,
      'gamehistory': gameHistory,
      'target': target,
      'usehormon': useHormon,
      'cannon': cannon,
      'unlikedfood': unLikeFood
    });
    return response.fold((l) => l, (r) => r);
  }

  getpackages(String url) async {
    var request = await crud.postData(url, {});
    return request.fold((l) => l, (r) => r);
  }

  subscribeData(String url, String userid, String picId, String imagename,
      String image64) async {
    var request = await crud.postData(url, {
      'id_user': userid,
      'id_p': picId,
      'photo_trans': imagename,
      'image64': image64
    });
    return request.fold((l) => l, (r) => r);
  }

  getAllPlayersForCaptin(String url) async {
    var request = await crud.postData(url, {});
    return request.fold((l) => l, (r) => r);
  }

  getAllExercisesForPlayer(String url, String id, int day) async {
    var response =
        await crud.postData(url, {'acc_id': id, 'day_id': day.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
