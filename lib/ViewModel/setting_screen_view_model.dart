import 'dart:developer';

import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/set_notification_data_model/set_notification_data_model.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/Repo/setting_repo.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingScreenViewModel extends GetxController {
  final repo = SettingRepo();

  bool _notificationStatus = User.data.notification;
  bool get notificationStatus => _notificationStatus;
  ApiResponse<SetNotificationDataModel> notificationResponse =
      ApiResponse.init();

  toggleNotificationStatus(bool value, bool api) {
    _notificationStatus = value;
    log(notificationStatus.toString(), name: "notification status");
    update();
    if (api) {
      setNotificationApi();
    }
  }

  setNotificationResponse(ApiResponse<SetNotificationDataModel> response) {
    notificationResponse = response;
    notificationResponse.toString();
    update();
  }

  Future<void> setNotificationApi() async {
    var data = {"device_token": deviceToken};
    setNotificationResponse(ApiResponse.loading());
    await repo.setNotificationApi(data).then((value) async {
      setNotificationResponse(ApiResponse.completed(value));
      bool status = value.data?.notificationEnabled ?? _notificationStatus;
      toggleNotificationStatus(status, false); // for ui
      User.data.notification = status;
      await User(map: User.data.map).save();
      log(User.data.notification.toString(), name: 'setNotification');
    }).onError((error, stackTrace) {
      setNotificationResponse(ApiResponse.error(error.toString()));
    });
  }
}
