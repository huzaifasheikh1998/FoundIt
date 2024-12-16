import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/create_order_data_model/create_order_data_model.dart';
import 'package:foundit/Model/create_product_lov_data_model/create_product_lov_data_model.dart';
import 'package:foundit/Model/create_product_lov_data_model/variant.dart';
import 'package:foundit/Model/order_data.dart';
import 'package:foundit/Model/order_details_initial_param.dart';
import 'package:foundit/Model/track_order_data_model/retail_costs.dart';
import 'package:foundit/Model/track_order_data_model/track_order_data_model.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/Repo/order_detail_repo.dart';
import 'package:foundit/Utils/extension.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/View/Home/OrderDetails2.dart';
import 'package:foundit/View/Home/OrderPayment.dart';
import 'package:foundit/main.dart';
import 'package:foundit/resources/css_picker/css.dart';
import 'package:get/get.dart';

class OrderDetailViewModel extends GetxController {
  final repo = OrderDetailRepo();
  ApiResponse<CreateProductLovDataModel> createProductLovResponse =
      ApiResponse.init();
  ApiResponse<CreateOrderDataModel> createOrderResponse = ApiResponse.init();
  ApiResponse<TrackOrderDataModel> trackOrderResponse = ApiResponse.init();

  String? qrCodeId;
  String? qrCodeImg;
  Variant? variantValue;

  TextEditingController quantityController =
      TextEditingController(text: !kDebugMode ? null : '23');

  TextEditingController addressController =
      TextEditingController(text: !kDebugMode ? null : 'Address 123');
  TextEditingController countryController = TextEditingController(
      text: !kDebugMode ? "United States" : 'United States');

  TextEditingController stateController =
      TextEditingController(text: !kDebugMode ? null : "");
  TextEditingController cityController =
      TextEditingController(text: !kDebugMode ? null : "");
  TextEditingController zipCodeController =
      TextEditingController(text: !kDebugMode ? null : '77830');
  TextEditingController taxNumberController =
      TextEditingController(text: !kDebugMode ? null : '2134678888');

  Timer _debounce = Timer(Duration(milliseconds: 500), () {});

  // @override
  // void onInit() {
  //   super.onInit();

  //   fetchCreateProfileLovResponse();
  // }

  setState(String value) {
    stateController.text = value;
    update();
  }

  setCity(String value) {
    cityController.text = value;
    update();
  }

  setCreateProfileLovResponse(ApiResponse<CreateProductLovDataModel> value) {
    createProductLovResponse = value;
    update();
  }

  setCreateOrderResponse(ApiResponse<CreateOrderDataModel> value) {
    createOrderResponse = value;
  }

  setTrackOrderResponse(ApiResponse<TrackOrderDataModel> value) {
    trackOrderResponse = value;
    update();
  }

  setVariantValue(Variant? value) {
    variantValue = value;
  }

  setQrCode(OrderDetailsInitialParam value) {
    qrCodeId = value.orderId;
    qrCodeImg = value.orderQrImg;
  }

  Future<void> fetchCreateProfileLovResponse() async {
    setCreateProfileLovResponse(ApiResponse.loading());
    await repo.fetchCreateProductLovResponse().then((value) async {
      setCreateProfileLovResponse(ApiResponse.completed(value));

      stateList = createProductLovResponse.data?.stateList ?? [];
    }).onError((error, stackTrace) {
      setCreateProfileLovResponse(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchCreateOrderResponse(Map<String, dynamic> data) async {
    // log(data.toString(), name: "orderDetailData");
    setTrackOrderResponse(ApiResponse.loading());
    setCreateOrderResponse(ApiResponse.loading());
    await repo.fetchCreateOrderReponse(data).then((value) async {
      setCreateOrderResponse(ApiResponse.completed(value));
      if (value.data?.original?.result?.id != null) {
        Timer(Duration(seconds: 3), () {
          fetchTrackOrderResponse(value.data!.original!.result!.id.toString(),
              reload: true);
        });
      } else {
        setCreateOrderResponse(ApiResponse.error("Something went wrong"));
        Utils.showSnackBar(type: false, msg: "Something went wrong");
      }

      // Utils.showSnackBar(type: true, msg: value.message.toString());
    }).onError((error, stackTrace) {
      setCreateOrderResponse(ApiResponse.error(error.toString()));
      setTrackOrderResponse(ApiResponse.error(error.toString()));
      Utils.showSnackBar(type: false, msg: error.toString());
    });
  }

  Future<void> fetchTrackOrderResponse(String id, {bool reload = false}) async {
    // log(id.toString(), name: "trackORderId");
    setTrackOrderResponse(ApiResponse.loading());
    await repo.fetchTrackOrderResponse(id).then((value) async {
      setTrackOrderResponse(ApiResponse.completed(value));
      RetailCosts? cost = value.data!.result?.retailCosts;
      if (cost?.total == null) {
        if (reload) {
          log("reloaded", name: 'reload');
          Timer(Duration(seconds: 1), () {
            fetchTrackOrderResponse(id);
          });
        } else {
          setTrackOrderResponse(ApiResponse.error("Unable to create order"));
        }
      } else {
        Utils.showSnackBar(type: true, msg: value.message.toString());

        Get.to(() => OrderPaymentScreen(
            orderData: OrderData(
                orderId: id,
                size: variantValue?.variantSize ?? '',
                qty: value.data!.result?.items?.first.quantity ?? 0,
                price: cost?.subtotal ?? '0',
                shipping: cost?.shipping ?? "0",
                tax: cost?.tax ?? '0',
                total: cost?.total ?? '0')));
      }
    }).onError((error, stackTrace) {
      setTrackOrderResponse(ApiResponse.error(error.toString()));
      Utils.showSnackBar(type: false, msg: error.toString());
    });
  }

  // Future<void> callApiResponse({bool reload = true}) async {
  //   if (reload) {
  //     setOrderResponse(ApiResponse.loading());
  //   }
  //   await Future.wait(
  //           [myWalletApi(reload: reload), myWalletHistoryApi(reload: reload)])
  //       .whenComplete(() async {
  //     ApiResponse<dynamic> _response;
  //     if (myWalletResponse.status == Status.ERROR) {
  //       _response = ApiResponse.error(myWalletResponse.message);
  //     } else if (myWalletHistoryResponse.status == Status.ERROR) {
  //       _response = ApiResponse.error(myWalletHistoryResponse.message);
  //     } else {
  //       _response = ApiResponse.completed("data");
  //     }

  //     setOrderResponse(_response);
  //   });
  // }
// }

  checkValidation1(BuildContext context) {
    Utils.closeKeyBoard(context);

    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(Duration(milliseconds: 500), () {
      validation1(context);
    });
  }

  validation1(BuildContext context) {
    Utils.closeKeyBoard(context);

    if (variantValue == null) {
      Utils.showSnackBar(type: false, msg: "Please Select Variant");
    } else if (!Utils.validate(quantityController, "Quantity")) {
      return;
    } else {
      Get.to(() => OrderDetails2Screen(
            orderDetailViewModel: orderDetailViewModel,
          ));
    }
  }

  checkValidation2(BuildContext context) {
    Utils.closeKeyBoard(context);

    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(Duration(milliseconds: 500), () {
      validation2(context);
    });
  }

  validation2(BuildContext context) {
    if (!Utils.validate(addressController, "Address")) {
      return;
    } else if (!Utils.validate(stateController, "State ")) {
      return;
    } else if (!Utils.validate(cityController, "City")) {
      return;
    } else if (!Utils.validate(zipCodeController, "Zip Code")) {
      return;
    } else if (!Utils.validate(taxNumberController, "Tax Number")) {
      return;
    } else {
      Map<String, dynamic> data = {
        "qr_code_id": qrCodeId,
        "user_id": User.data.userId.toString(),
        "shipping": "STANDARD",
        "recipient": {
          "name": User.data.userName,
          "company": "${User.data.userName} Inc",
          "address1": addressController.text,
          "country_name": "United States",
          "state_name": stateController.text,
          "city": cityController.text,
          "zip": zipCodeController.text,
          "email": User.data.userEmail,
        },
        "variant_id": (variantValue?.variantId ?? 0).toString(),
        "quantity": quantityController.text.toInt(),
        "currency": "USD",
        "printable_file": qrCodeImg
      };
      // Get.to(() => InAppPayment());

      fetchCreateOrderResponse(data);
    }
  }
}
