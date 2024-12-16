import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/notification_data_model/notification_data_model.dart';
import 'package:foundit/resources/app_url/app_url.dart';

class NotificationRepo {
  final _apiServices = NetworkApiServices.ins;

  Future<NotificationDataModel> fetchNotificationReponse() async {
    try {
      dynamic response = await _apiServices.get(AppUrl.notificationUrl,
          baseUrl: AppUrl.printfulbaseUrl);
      return NotificationDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
