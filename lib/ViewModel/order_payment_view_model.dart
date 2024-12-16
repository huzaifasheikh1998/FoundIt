import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/order_payment_data_model/order_payment_data_model.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/Repo/order_payment_repo.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/View/Alert/result_alert.dart';
import 'package:get/get.dart';

import '../Model/order_data.dart';

class OrderPaymentViewModel extends GetxController {
  final repo = OrderPaymentRepo();
  Map<String, dynamic>? cardDetail;
  OrderData? orderData;
  Timer _debounce = Timer(Duration(milliseconds: 500), () {});
  ApiResponse<OrderPaymentDataModel> orderPaymentResponse = ApiResponse.init();

  setCardDetail(Map<String, dynamic> value) {
    cardDetail = value;
    update();
  }

  setOrderData(OrderData value) {
    orderData = value;
  }

  setOrderPaymentResponse(ApiResponse<OrderPaymentDataModel> value) {
    orderPaymentResponse = value;
    update();
  }

  Future<void> fetchOrderPaymentResponse(
      Map<String, dynamic> data, BuildContext context) async {
    setOrderPaymentResponse(ApiResponse.loading());
    await repo.fetchOrderPaymentResponse(data).then((value) async {
      setOrderPaymentResponse(ApiResponse.completed(value));
      resultAlert(
          result: true,
          title: "Order Payment",
          msg: value.message.toString(),
          context: context);
    }).onError((error, stackTrace) {
      log(error.toString(), name: 'fetchOrderPaymentReponse');
      setOrderPaymentResponse(ApiResponse.error(error.toString()));
      resultAlert(
          result: false,
          title: "Order Payment",
          msg: error.toString(),
          context: context);
    });
  }

  checkValidation(BuildContext context, OrderData orderData) {
    setOrderData(orderData);
    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(Duration(milliseconds: 500), () {
      validation(context);
    });
  }

  validation(BuildContext context) {
    Utils.closeKeyBoard(context);

    if (cardDetail == null) {
      Utils.showSnackBar(
          type: false, msg: "Please enter card detail by clicking on card");
    } else {
      Map<String, dynamic> paymentData = {
        'number': cardDetail!['number'],
        'exp_month': cardDetail!['exp_month'],
        'exp_year': cardDetail!['exp_year'],
        'cvc': cardDetail!['cvc'],
        'amount': orderData!.total,
        'description': 'des',
        'order_id': orderData!.orderId,
        'user_id': User.data.userId.toString()
      };
      // cardDetail!.remove('card_holder_name');
      log(paymentData.toString(), name: "paymentData");
      fetchOrderPaymentResponse(paymentData, context);
    }
  }
}
