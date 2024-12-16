import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/order_payment_data_model/order_payment_data_model.dart';
import 'package:foundit/resources/app_url/app_url.dart';

class OrderPaymentRepo {
  final _apiServices = NetworkApiServices.ins;

  Future<OrderPaymentDataModel> fetchOrderPaymentResponse(dynamic data) async {
    try {
      dynamic response = await _apiServices.post(AppUrl.orderPayment, data,
          baseUrl: AppUrl.printfulbaseUrl, formData: true);
      return OrderPaymentDataModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
