import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:foundit/Model/scan_qr_data_model/scan_qr_data_model.dart';
import 'package:foundit/Repo/scan_qr_repo.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/View/Home/BoxItemScreen.dart';
import 'package:get/get.dart';

class ScanQrViewModel extends GetxController {
  final ScanQrRepo repo;
  ScanQrViewModel(this.repo);
  ApiResponse<ScanQrDataModel> scanApiResponse = ApiResponse.init();

  setScanApiResponse(ApiResponse<ScanQrDataModel> value) {
    scanApiResponse = value;
    update();
  }

  Future<void> fetchScanApiResponse(String id) async {
    setScanApiResponse(ApiResponse.loading());
    await repo.fetchScanQrResponse(id).then((value) {
      setScanApiResponse(ApiResponse.completed(value));

      Utils.showSnackBar(type: true, msg: value.message.toString());
      Box box = Box(
          id: value.data?.id,
          boxName: value.data?.boxName,
          thumbnail: value.data?.thumbnail);
      Get.off(BoxItemScreen(box: box));
    }).onError((error, stackTrace) {
      setScanApiResponse(ApiResponse.error(error.toString()));
      if (Get.currentRoute == "/ScanQrScreen") {
        Get.back();
      }
      Utils.showSnackBar(type: false, msg: error.toString());
    });
  }
}
