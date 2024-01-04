import 'package:fitnessapp/core/classes/requeststate.dart';

handlingdata(response) {
  if (response is RequestStatus) {
    return response;
  } else {
    return RequestStatus.success;
  }
}
