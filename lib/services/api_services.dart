import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/Controller/UserController.dart';
import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/NavBar/Navbar.dart';
// import 'dart:html';

import 'package:foundit/View/Auth/CreateNewPasword.dart';
import 'package:foundit/View/Auth/Login.dart';
import 'package:foundit/View/Auth/Otp.dart';
import 'package:foundit/View/Auth/PreLogin.dart';
import 'package:foundit/View/Auth/SignupOtp.dart';
import 'package:foundit/Model/CategoryModel.dart';
import 'package:foundit/Model/box_item.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:foundit/Model/plans.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/View/Home/SubscriptionPackages.dart';
import 'package:foundit/View/subscriptions_new.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/services/revenue_cat_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = "https://foundit.thesuitchstaging.com/api/v9/";
// String apiUrl = "https://foundit.thesuitchstaging.com/api/";
final getBoxes = Get.put(UserController());
final catmodel = Get.put(UserController());

class ApiServices {
  callregister(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    log(data.toString());
    final uri = Uri.parse('${apiUrl}register');
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        AuthToken = res_data['data']['api_token'];
        print("ABCDDD${AuthToken.toString()}");
        Get.back();
        Get.to(() => SignupOtpScreen(
              token: res_data['data']['api_token'],
            ));
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();

        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  verifyotp(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    log(data.toString());
    final uri = Uri.parse('${apiUrl}verifyemail');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data['token']}',
    };
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        // AuthToken = res_data['data']['api_token'];
        Get.back();
        await User(map: res_data['data']).save();
        await User().init();
        AuthToken = User.data.apiToken;
        NetworkApiServices.ins.updateAuthDio(User.data.apiToken);
        final bottomcontroller = Get.put(BottomController());
        bottomcontroller.navBarChange(0);
        Get.to(() => MainScreen());
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();

        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  callLogin(context, data, isChecked) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );

    final uri = Uri.parse('${apiUrl}login');
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      // var res_user_data = jsonEncode(res_data['data']);
      // var res_data = json.decode(response.body.toString());
      print("objec t : " + res_data.toString());

      if (response.statusCode == 200) {
        if (res_data['status'] == 'true') {
          SharedPreferences sp = await SharedPreferences.getInstance();
          if (isChecked) {
            sp.remove("userEmail");
            sp.remove("userPassword");

            sp.setString("userEmail", data['email']);
            sp.setString("userPassword", data['password']);
          } else {
            sp.remove("userEmail");
            sp.remove("userPassword");
          }


          await User(map: res_data['data']).save().then((value) async {
            await User().init();
          });
          // await User().init();
          AuthToken = User.data.apiToken;
          NetworkApiServices.ins.updateAuthDio(User.data.apiToken);
          // Get.to(() => SubscriptionPackagesScreenNew());
          // Get.back();
          final bottomcontroller = Get.put(BottomController());
          bottomcontroller.navBarChange(0);
          Get.offAll(() => MainScreen());

          Get.snackbar('Success', res_data["message"],
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green);
          RevenueCatApi.loginRevenueCat(res_data["data"]["id"].toString());

        } else {
          if (res_data["message"] == "Account is not Verfied") {
            Get.to(() => SignupOtpScreen(
                  token: res_data['data']['api_token'],
                ));
            Get.snackbar('Please', 'Check your email and verify OTP',
                snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
          } else {
            Get.back();
            Get.snackbar('Error', res_data["message"],
                snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
          }
        }
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  callforgetPassword(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );

    log(data.toString());
    final uri = Uri.parse('${apiUrl}otpsend');
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        Get.to(() => OtpScreen());
        // select == 'forgetpass' ? Get.to(() => VerificationScreen()) : Get.back();
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  addMember(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );

    log(data.toString());
    final uri = Uri.parse('${apiUrl}member/add');
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: data,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        // select == 'forgetpass' ? Get.to(() => VerificationScreen()) : Get.back();
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  verifyForgetotp(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    log(data.toString());
    final uri = Uri.parse('${apiUrl}verifyforgot');
    final headers = {'Content-Type': 'application/json'};
    // final headers = {
    //   'Content-Type': 'application/json',
    // };
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        Get.to(() => CreateNewPaswordScreen());
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();

        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  callresetPassword(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    log(data.toString());
    final uri = Uri.parse('${apiUrl}reset');
    final headers = {
      'Content-Type': 'application/json',
    };
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        Get.back();
        Get.to(() => LoginScreen());
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();

        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  callLogout(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    log(data.toString());
    final uri = Uri.parse('${apiUrl}logout');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AuthToken}',
    };

    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );

      log(response.statusCode.toString());
      log(response.body.toString());
      var res_data = json.decode(response.body.toString());

      log(res_data.toString());

      if (res_data['status'] == 'true') {
        await User().clear();
        Get.offAll(() => PreLoginScreen());

        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();

        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  getResendOtp(context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer${AuthToken}',
    };
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}emailotp'),
        headers: headers,
      );
      var res_data = json.decode(response.body.toString());
      if (res_data['status'] == 'true') {
        Get.back();
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        print(res_data);
      } else {
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.black);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          colorText: Colors.white);
    }
  }

  callforgetPassword1(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );

    log(data.toString());
    final uri = Uri.parse('${apiUrl}otpsend');
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        Get.back();
        // select == 'forgetpass' ? Get.to(() => VerificationScreen()) : Get.back();
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  // createBox(context, data) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Center(child: CircularProgressIndicator(
  //   color: Color(0xffEA8806),
  // ));
  //     },
  //   );
  //   log(data.toString());
  //   final uri = Uri.parse('${apiUrl}box/store');
  //   final headers = {
  //     'Authorization': 'Bearer${AuthToken}',
  //   };

  //   String jsonBody = json.encode(data);
  //   try {
  //     http.Response response = await http.post(
  //       uri,
  //       headers: headers,
  //       body: jsonBody,
  //     );
  //     var res_data = json.decode(response.body.toString());

  //     log(res_data.toString());

  //     if (res_data['status'] == 'true') {
  //       Get.offAll(() => LoginScreen());
  //       Get.snackbar('Success', res_data['message'], snackPosition: SnackPosition.TOP, colorText: Colors.white, backgroundColor: Colors.green);
  //     } else {
  //       Get.back();

  //       Get.snackbar('Error', res_data['message'], snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     Get.back();

  //     Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //   }
  // }
  createBox(context, data, imageFile) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffEA8806),
        ));
      },
    );

    final uri = Uri.parse('${apiUrl}box/store');
    var request = http.MultipartRequest('POST', uri);
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };

    try {
      request.fields["box_name"] = data["box_name"].toString();
      request.fields["user_date"] = data["user_date"].toString();

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'thumbnail',
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType:
              MediaType("thumbnail", "${imageFile.path.split('.').last}"),
        );
        request.files.add(multipartFile);
      }

      String jsonBody = json.encode(request.fields);
      request.headers.addAll(headers);
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      var res_data = json.decode(res.body.toString());

      log(res_data.toString());
      if (response.statusCode == 200) {
        if (res_data['status'] == "true") {
          Get.back();
          final bottomcontroller = Get.put(BottomController());
          bottomcontroller.navBarChange(1);
          Get.to(() => MainScreen());
          Get.snackbar('Success', 'Box Created Successfully');
        } else {
          print("errrrrrr");
          Get.back();
          Get.snackbar('Error', "Something went wrong",
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.black);
        }
      } else {
        Get.back();
        Get.snackbar('Error', "Something went wrong",
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.black);
      }
    } catch (e) {
      print(e);
      Get.back();
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.black);
    }
  }

  callGetBoxes(context) async {
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}box/boxes'),
        headers: headers,
      );
      log(headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());

      var res_data = json.decode(response.body.toString());
      if (res_data['status'] == "true") {
        getBoxes.User(GetBoxes.fromJson(res_data));

        print(res_data);
        return true;
      } else {
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.black);
        return false;
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          colorText: Colors.white);
      return false;
    }
  }

  callGetBoxItems(BuildContext context, String id) async {
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    final String uri = '${apiUrl}user/box/items?box_id=' + id.toString();
    log(uri.toString());
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: headers,
      );
      var res_data = json.decode(response.body);
      log(response.statusCode.toString());
      log(res_data.toString());
      if (response.statusCode == 200) {
        items.clear();
      }
      if (res_data['status'] == "true") {
        for (var i = 0; i < res_data['Data'].length; i++) {
          items.value.add(BoxItem.fromJson(res_data['Data'][i]));
        }
        print(items.toString());
        print(res_data);
        return true;
      } else {
        // Get.snackbar('Error', res_data['message'],
        //     snackPosition: SnackPosition.TOP,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.black);
        return false;
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          colorText: Colors.white);
      return false;
    }
  }

  // CallAddnewitem(context, data, imageFile1) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Center(
  //           child: CircularProgressIndicator(
  //         strokeWidth: 2,
  //       ));
  //     },
  //   );

  //   final uri = Uri.parse('https://foundit.thesuitchstaging.com/api/item/store');
  //   var request = http.MultipartRequest('POST', uri);
  //   final headers = {
  //     'Authorization': 'Bearer ${AuthToken}',
  //   };

  //   try {
  //     request.fields["item_name"] = data["item_name"].toString();
  //     request.fields["box_id"] = data["box_id"];
  //     request.fields["category_id"] = data["category_id"];

  //     if (imageFile1 != null) {
  //       var multipartFile = await http.MultipartFile.fromPath(
  //         'thumbnail',
  //         imageFile1.path,
  //         filename: imageFile1.path.split('/').last,
  //         contentType: MediaType("thumbnail", "${imageFile1.path.split('.').last}"),
  //       );
  //       request.files.add(multipartFile);
  //     }

  //     String jsonBody = json.encode(request.fields);
  //     request.headers.addAll(headers);
  //     var response = await request.send();
  //     log("osama " + request.fields.toString());
  //     final res = await http.Response.fromStream(response);
  //     log("osama " + res.toString());
  //     var res_data = json.decode(res.body.toString());
  //     log(res_data.toString());
  //     if (res_data['status'] == "true") {
  //       Get.back();
  //       Get.to(() => Box1Screen());
  //       // final bottomcontroller = Get.put(BottomController());
  //       // bottomcontroller.navBarChange(1);
  //       // Get.to(() => MainScreen());
  //       Get.snackbar('Success', res_data["message"]);
  //     } else {
  //       Get.back();
  //       print("errrrrrr");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //

  Future<bool> getAllCategories() async {
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    // log(token);
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}category/list'),
        headers: headers,
      );
      // log(response.statusCode.toString());
      // log(response.body.toString());

      var res_data = json.decode(response.body.toString());
      if (res_data['status'] == "true") {
        catmodel.CatModel(CategoryModel.fromJson(res_data));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  CallAddnewitem(context, data, imageFile1) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffEA8806),
        ));
      },
    );

    final uri = Uri.parse('${apiUrl}item/store');

    try {
      var request = http.MultipartRequest('POST', uri);
      final headers = {
        'Authorization': 'Bearer ${AuthToken}',
      };
      request.fields["item_name"] = data["item_name"].toString();
      request.fields["box_id"] = data["box_id"];
      request.fields["category_id"] = data["category_id"].toString();
      request.fields["description"] = data["description"].toString();
      request.fields["user_date"] = data["user_date"].toString();

      if (imageFile1 != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'thumbnail',
          imageFile1.path,
          filename: imageFile1.path.split('/').last,
          contentType:
              MediaType("thumbnail", "${imageFile1.path.split('.').last}"),
        );
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      var response = await request.send();

      final res = await http.Response.fromStream(response);
      log(res.statusCode.toString());
      log(res.body.toString());
      var res_data = json.decode(res.body.toString());
      if (res_data['status'] == "true") {
        Get.back();
        Get.back();
        Get.snackbar('Success', 'Item has been added in the box',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        callGetBoxItems(context, data["box_id"]);
        // Get.off(() => Box1Screen());
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  Future<bool> deleteBoxItem(String id, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffEA8806),
        ));
      },
    );
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    // log(token);
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}user/item/delete'),
        body: {'id': id.trim()},
        headers: headers,
      );

      var res_data = json.decode(response.body.toString());
      if (res_data['status'] == "true") {
        Get.back();
        Get.snackbar('Success', 'Item has been deleted from box',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        return true;
      } else {
        Get.back();
        return false;
      }
    } catch (e) {
      print(e);
      Get.back();
      return false;
    }
  }

  Future<bool> deleteBox(String id, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffEA8806),
        ));
      },
    );
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    // log(token);
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}user/box/delete'),
        body: {'id': id.trim()},
        headers: headers,
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      var res_data = json.decode(response.body.toString());
      if (res_data['status'] == "true") {
        Get.back();
        Get.snackbar('Success', 'Box has been deleted',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        return true;
      } else {
        Get.back();
        return false;
      }
    } catch (e) {
      print(e);
      Get.back();
      return false;
    }
  }

  Future<String> generateBoxQrCode(String id, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffEA8806),
        ));
      },
    );
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    // log(token);
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}box/qr'),
        body: {'box_id': id.trim()},
        headers: headers,
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      var res_data = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        final String Qr = res_data['Data']['QR'].toString().trim();

        Get.back();

        return Qr;
      } else {
        Get.back();
        return "";
      }
    } catch (e) {
      print(e);
      Get.back();
      return "";
    }
  }

  Future<List<Plan>> getPlans() async {
    final Uri uri = Uri.parse('${apiUrl}plans');
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    List<Plan> plans = [];
    try {
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final res_body = json.decode(response.body);
        final List list = res_body['Data'];
        if (res_body['status'] == "true" && list.length > 0) {
          for (var i = 0; i < list.length; i++) {
            plans.add(Plan(map: list[i]));
          }
        }
      }
      return plans;
    } catch (e) {
      print(e.toString());
      return plans;
    }
  }

  Future<void> getSubscriptionPlan() async {
    final Uri uri = Uri.parse('${apiUrl}sub/get');
    final headers = {
      'Authorization': 'Bearer ${AuthToken}',
    };
    try {
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final res_body = json.decode(response.body);
        if (res_body['status'] == "true") {
          await User(map: res_body['Data']).save();
          await User().init();
        }
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  createSubscriptionPlan(context, data) async {
    log(data.toString());
    final uri = Uri.parse('${apiUrl}sub/store');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthToken}',
    };
    // final headers = {
    //   'Content-Type': 'application/json',
    // };
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == 'true') {
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  Future<void> cancelSubscriptionPlan(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: Color(0xffEA8806),
        ));
      },
    );
    log(data.toString());
    final uri = Uri.parse('${apiUrl}sub/cancel');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthToken}',
    };
    // final headers = {
    //   'Content-Type': 'application/json',
    // };
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == "true") {
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();

        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
  }

  Future<void> filterApi(
      BuildContext context, Map<String, dynamic> data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xffEA8806),
        ));
      },
    );

    // log(token);
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthToken}',
      };
      final response = await http.post(
        Uri.parse('${apiUrl}lov'),
        body: jsonEncode(data),
        headers: headers,
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      var res_data = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
      Get.back();
    }
  }
}
