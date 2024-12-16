import 'package:foundit/Model/CategoryModel.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // static LoginModel user = LoginModel();
  static GetBoxes user = GetBoxes();
  static CategoryModel catmodel = CategoryModel();
  // static GetBehaviour behaviour = GetBehaviour();
  // static GetSynopsesModel synopsis = GetSynopsesModel();
  // static GetAlarm alarm = GetAlarm();
  void User(GetBoxes data) {
    user = data;
    update();
  }

  void CatModel(CategoryModel data) {
    catmodel = data;
    update();
  }

  // void Behaviour(GetBehaviour data) {
  //   behaviour = data;
  //   update();
  // }

  // void Synopsis(GetSynopsesModel data) {
  //   synopsis = data;
  //   update();
  // }

  // void Alarm(GetAlarm data) {
  //   alarm = data;
  //   update();
  // }

  //   List<Photos> photoList = [];
  // Future<List<Photos>> getPhotoApi() async {
  //   final response = await http
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     for (Map i in data) {
  //       Photos photos =
  //           Photos(title: i['title'], id: i['id'].toString(), url: i['url']);
  //       photoList.add(photos);
  //     }
  //     return photoList;
  //   } else {
  //     return photoList;
  //   }
  // }
}

// class CustomBox {
//   final int box_id;
//   final String box_name;
//   final String box_thumbnail;

//   const CustomBox(
//     this.box_id,
//     this.box_name,
//     this.box_thumbnail,
//   );
// }
