import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class CRUD {
  Future<Either<RequestStatus, Map>> postData(String url, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          var resbody = await jsonDecode(response.body);
          if (resbody['message'] == 'NOT FOUND :)') {
            return const Left(RequestStatus.failure);
          } else {
            return Right(resbody);
          }
        } else {
          return const Left(RequestStatus.serverfailure);
        }
      } else {
        return const Left(RequestStatus.offline);
      }
    } catch (e) {
      return const Left(RequestStatus.serverfailure);
    }
  }
}
