import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/scan_qr_data_model/scan_qr_data_model.dart';
import 'package:foundit/resources/app_url/app_url.dart';

class ScanQrRepo {
  final _apiServices = NetworkApiServices.ins;
  Future<ScanQrDataModel> fetchScanQrResponse(id) async {
    try {
      dynamic response = await _apiServices.get(AppUrl.scanQrUrl + id,
          baseUrl: AppUrl.printfulbaseUrl);
      return ScanQrDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
