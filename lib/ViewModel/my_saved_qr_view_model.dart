import 'package:foundit/Data/response/api_response.dart';
import 'package:foundit/Model/my_save_qr_data_model/my_save_qr_data_model.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/Repo/my_saved_qr_repo.dart';
import 'package:get/get.dart';

class MySavedQrViewModel extends GetxController {
  // @override
  // void onInit() {
  //   fetchMySaveQrResponse(reload: true);
  //   super.onInit();
  // }

  final _repo = MySaveQrRepo();
  ApiResponse<MySaveQrDataModel> mySaveQrResponse = ApiResponse.init();

  setMySaveQrResponse(ApiResponse<MySaveQrDataModel> value) {
    mySaveQrResponse = value;
    update();
  }

  Future<void> fetchMySaveQrResponse() async {
    setMySaveQrResponse(ApiResponse.loading());
    await _repo.fetchSaveQrDataModel(User.data.userId.toString()).then((value) {
      setMySaveQrResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMySaveQrResponse(ApiResponse.error(error.toString()));
    });
  }
}
