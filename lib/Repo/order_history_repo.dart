import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/resources/app_url/app_url.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/order_history_data_model/data.dart';

class OrderHistoryRepo {
  final _apiServices = NetworkApiServices.ins;
  Future<OrderHistoryDataModel> fetchOrderHistoryResponse(String id) async {
    try {
      dynamic response = await _apiServices.get(AppUrl.orderHistory + id,
          baseUrl: AppUrl.printfulbaseUrl);
      return OrderHistoryDataModel.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> fetchCancelOrderReponse(dynamic data) async {
    try {
      dynamic response = await _apiServices.postFile(
          AppUrl.cancelOrderUrl, data,
          baseUrl: AppUrl.printfulbaseUrl);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> fetchRefundOrderReponse(
      dynamic data, List<XFile> file) async {
    try {
      dynamic response = await _apiServices.postMultipleFiles(
          AppUrl.cancelOrderUrl, data,
          files: file, baseUrl: AppUrl.printfulbaseUrl);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
