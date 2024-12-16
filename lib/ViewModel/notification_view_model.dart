import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/notification_data_model/notification_data_model.dart';
import 'package:foundit/Repo/notification_repo.dart';
import 'package:get/get.dart';

class NotificationViewModel extends GetxController {
  final NotificationRepo _repo;
  NotificationViewModel(this._repo);
  @override
  void onInit() {
    super.onInit();
    fetchNotificationResponse();
  }

  ApiResponse<NotificationDataModel> notificationResponse = ApiResponse.init();

  setNotificationResponse(ApiResponse<NotificationDataModel> value) {
    notificationResponse = value;
    update();
  }

  Future<void> fetchNotificationResponse() async {
    setNotificationResponse(ApiResponse.loading());
    await _repo
        .fetchNotificationReponse()
        .then((value) => setNotificationResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            setNotificationResponse(ApiResponse.error(error.toString())));
  }
}
