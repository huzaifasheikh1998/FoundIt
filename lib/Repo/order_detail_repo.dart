import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/create_order_data_model/create_order_data_model.dart';
import 'package:foundit/Model/create_product_lov_data_model/create_product_lov_data_model.dart';
import 'package:foundit/Model/track_order_data_model/track_order_data_model.dart';
import 'package:foundit/resources/app_url/app_url.dart';

class OrderDetailRepo {
  final _apiServices = NetworkApiServices.ins;

  Future<CreateProductLovDataModel> fetchCreateProductLovResponse() async {
    try {
      dynamic response = await _apiServices.get(AppUrl.createProductLovUrl,
          baseUrl: AppUrl.printfulbaseUrl);
      return CreateProductLovDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<CreateOrderDataModel> fetchCreateOrderReponse(dynamic data) async {
    try {
      dynamic response = await _apiServices.post(AppUrl.createOrderUrl, data,
          baseUrl: AppUrl.printfulbaseUrl);
      return CreateOrderDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<TrackOrderDataModel> fetchTrackOrderResponse(String id) async {
    try {
      dynamic response = await _apiServices.get(AppUrl.trackOrderUrl + id,
          baseUrl: AppUrl.printfulbaseUrl);
      return TrackOrderDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
