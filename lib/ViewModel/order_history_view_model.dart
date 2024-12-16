import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/Repo/order_history_repo.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/View/Alert/result_alert.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/order_history_data_model/data.dart';

class OrderHistoryViewModel extends GetxController {
  List<XFile> images = [];

  Future<void> pickImages() async {
    try {
      List<XFile>? resultList = await ImagePicker().pickMultiImage(
        imageQuality: 50,
        maxHeight: 500,
      );
      if (resultList.isNotEmpty) {
        images.addAll(resultList);
        // Optionally, you can update the UI to reflect the selected images
        update(); // Assuming this method notifies the UI to update
      }
    } catch (e) {
      print(e);
    }
  }

  void removeImage(index) {
    images.removeAt(index);
    update();
  }

  final TextEditingController reasonController = TextEditingController();
  // @override
  // void onInit() {
  //   fetchOrderHistoryResponse(reload: true);
  //   super.onInit();
  // }

  bool loading = false;

  void isLoading(bool value) {
    loading = value;
    update();
  }

  final repo = OrderHistoryRepo();
  int selected = 1;
  List<OrderInstance>? selectedData;

  ApiResponse<OrderHistoryDataModel> orderHistoryResponse = ApiResponse.init();
  setOrderHistoryReponse(ApiResponse<OrderHistoryDataModel> value) {
    orderHistoryResponse = value;
    update();
  }

  setSelected(int type) {
    log(selectedData.toString(), name: "selected data");
    switch (type) {
      case 1:
        selectedData = orderHistoryResponse.data?.data.pending ?? [];
        update();
        break;
      case 2:
        selectedData = orderHistoryResponse.data?.data.canceled ?? [];
        break;
      case 3:
        selectedData = orderHistoryResponse.data?.data.completed ?? [];
        break;
    }
    selected = type;
    // log(((selectedData.toString()) ?? "null").toString(),
    //     name: "selected data");
    update();
  }

  Future<void> fetchOrderHistoryResponse() async {
    // selectedData = OrderHistoryData(count: 0, data: []);

    setOrderHistoryReponse(ApiResponse.loading());
    await repo
        .fetchOrderHistoryResponse(User.data.userId.toString())
        .then((value) async {
      print("valueeeeeeeee ===> $value");
      log("valueeeeee ===> $value");
      await setOrderHistoryReponse(ApiResponse.completed(value));
      setSelected(1);
    }).onError((error, stackTrace) {
      setOrderHistoryReponse(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchCancelOrderResponse(
      Map<String, dynamic> data, context) async {
    // log(data.toString(), name: "orderDetailData");
    isLoading(true);
    await repo.fetchCancelOrderReponse(data).then((value) async {
      isLoading(false);
      if (value["status"] == true) {
        resulCanceltAlert(
            result: true,
            title: "Success",
            msg: "Your order has been cancelled",
            context: context);
      }

      // Utils.showSnackBar(type: true, msg: value.message.toString());
    }).onError((error, stackTrace) {
      isLoading(false);
      resulCanceltAlert(
          result: false,
          title: "Failed",
          msg: "Something went wrong",
          context: context);
      Utils.showSnackBar(type: false, msg: error.toString());
    });
    update();
  }

  Future<void> fetchRefundOrderResponse(
      Map<String, dynamic> data, context, List<XFile> file) async {
    // log(data.toString(), name: "orderDetailData");
    isLoading(true);
    await repo.fetchRefundOrderReponse(data, file).then((value) async {
      isLoading(false);
      if (value["status"] == true) {
        resulCanceltAlert(
            result: true,
            title: "Success",
            msg: "Your request of refund has been submitted",
            context: context);
      }

      // Utils.showSnackBar(type: true, msg: value.message.toString());
    }).onError((error, stackTrace) {
      isLoading(false);
      resulCanceltAlert(
          result: false,
          title: "Failed",
          msg: "Something went wrong",
          context: context);
      Utils.showSnackBar(type: false, msg: error.toString());
    });
    update();
  }
}
