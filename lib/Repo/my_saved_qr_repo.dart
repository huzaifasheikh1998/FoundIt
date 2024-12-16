import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/my_save_qr_data_model/my_save_qr_data_model.dart';
import 'package:foundit/resources/app_url/app_url.dart';

class MySaveQrRepo {
  final _apiServices = NetworkApiServices.ins;
  Future<MySaveQrDataModel> fetchSaveQrDataModel(String id) async {
    try {
      dynamic response = await _apiServices.get(AppUrl.saveQrUrl + id,
          baseUrl: AppUrl.printfulbaseUrl);
      return MySaveQrDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
