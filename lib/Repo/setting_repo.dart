import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/set_notification_data_model/set_notification_data_model.dart';
import 'package:foundit/resources/app_url/app_url.dart';

class SettingRepo {
  final apiServices = NetworkApiServices.ins;

  Future<SetNotificationDataModel> setNotificationApi(
      Map<String, dynamic> data) async {
    try {
      dynamic response =
          await apiServices.post(AppUrl.updateNotificationUrl, data,baseUrl: AppUrl.baseUrl);
      return SetNotificationDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
