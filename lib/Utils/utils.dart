import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/ViewModel/order_history_view_model.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static cancelOrderDialogBox(
      {required BuildContext context,
      required VoidCallback submit,
      required TextEditingController reasonController,
      required int selected}) {
    final _controller = Get.put(OrderHistoryViewModel());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<OrderHistoryViewModel>(
          init: _controller,
          builder: (controller) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Color(0xffF9F9F9),
            title: Center(
              child: Text(
                'Cancel Order',
                style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold),
              ),
            ),
            // content:
            actions: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Reason',
                  style: TextStyle(
                    color: Color(0xff667080),
                  ),
                ),
              ),
              7.h.verticalSpace,
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.r),
                    filled: true,
                    fillColor: Color(0xffFFFFFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: Color(0xff667080).withOpacity(.6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: Color(0xff667080).withOpacity(.6),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: Color(0xff667080).withOpacity(.6),
                      ),
                    ),
                  ),
                ),
              ),
              20.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _controller.loading
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 40.h,
                            width: 136.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              border: Border.all(
                                color: Color(0xffF09722),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color(0xffF09722),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: submit,
                    child: Container(
                      height: 40.h,
                      width: _controller.loading ? Get.width * .65 : 136.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffF09722),
                              Color(0xffF5A235),
                              Color(0xffF5A235),
                              Color(0xff0EA8806),
                              // Color(0xff784C11),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffF5A235),
                              blurRadius: 1.r,
                            ),
                          ]),
                      child: Center(
                        child: _controller.loading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static refundOrderDialogBox(
      {required BuildContext context,
      required VoidCallback submit,
      required TextEditingController reasonController,
      required int selected,
      required VoidCallback uploadMedia}) {
    final _controller = Get.put(OrderHistoryViewModel());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<OrderHistoryViewModel>(
          init: _controller,
          builder: (controller) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Color(0xffF9F9F9),
            title: Center(
              child: Text(
                "Refund",
                style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold),
              ),
            ),
            // content:
            actions: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Reason',
                  style: TextStyle(
                    color: Color(0xff667080),
                  ),
                ),
              ),
              7.h.verticalSpace,
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.r),
                    filled: true,
                    fillColor: Color(0xffFFFFFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: Color(0xff667080).withOpacity(.6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: Color(0xff667080).withOpacity(.6),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: Color(0xff667080).withOpacity(.6),
                      ),
                    ),
                  ),
                ),
              ),
              24.h.verticalSpace,
              GestureDetector(
                onTap: uploadMedia,
                child: DottedBorder(
                  padding: EdgeInsets.all(18.r),
                  color: Color(0XFF2C2C2C).withOpacity(.3),
                  borderType: BorderType.RRect,
                  dashPattern: [8, 6],
                  radius: Radius.circular(8.r),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 50.sp,
                          color: Color(0XFF2C2C2C).withOpacity(.3),
                        ),
                        Text(
                          "Upload Media",
                          style: TextStyle(
                            color: Color(0XFF2C2C2C).withOpacity(.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              20.h.verticalSpace,
              _controller.images.isNotEmpty
                  ? Container(
                      height: Get.height * .2,
                      width: Get.width * .8,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children:
                            List.generate(_controller.images.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(_controller.images[index].path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: -3.h,
                                    right: -3.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        _controller.removeImage(index);
                                        print("object");
                                      },
                                      child: Container(
                                        width: 15.w,
                                        height: 15.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xffEA8806),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            size: 9.sp,
                                            color: Color(0xffEA8806),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  : SizedBox.shrink(),
              20.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _controller.loading
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 40.h,
                            width: 136.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              border: Border.all(
                                color: Color(0xffF09722),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color(0xffF09722),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: submit,
                    child: Container(
                      height: 40.h,
                      width: _controller.loading ? Get.width * .65 : 136.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffF09722),
                              Color(0xffF5A235),
                              Color(0xffF5A235),
                              Color(0xff0EA8806),
                              // Color(0xff784C11),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffF5A235),
                              blurRadius: 1.r,
                            ),
                          ]),
                      child: Center(
                        child: _controller.loading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static logInfo(String msg, {String? name}) {
    log('\x1B[32m$msg\x1B[0m',
        name: name != null ? '\x1B[32m$name\x1B[0m' : "");
  }

  static logError(String msg, {String? name}) {
    log('\x1B[31m$msg\x1B[0m',
        name: name != null ? '\x1B[31m$name\x1B[0m' : "");
  }

  static logErrorInfo(String msg, {String? name}) {
    log('\x1B[37m$msg\x1B[0m',
        name: name != null ? '\x1B[37m$name\x1B[0m' : "");
  }

  static String toLocalDateTime(String date, String time) {
    DateTime dd = DateFormat(
      'yyyy-MM-dd T HH:mm:ss Z',
    ).parse(date + " T " + time.split(".").first + " Z ");
    print(dd);

    return dd.toLocal().toString();
    // .toFormatDateTime(format: "DD-MM-yyyy hh:mm a");
    // String t = time.toFormatDateTime(format: "hh:mm a");
    // String d = date.toFormatDateTime(format: "DD-MM-yyyy");
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message, BuildContext context) {
    FToast toast = FToast();
    toast.init(context);
    toast.removeCustomToast();
    toast.showToast(
        child: Container(
      constraints: BoxConstraints(maxWidth: Get.height * 0.8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade900, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/app_icon.png',
            height: 25.h,
          ),
          10.horizontalSpace,
          Flexible(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }

  // static showSnack(String msg, BuildContext _context) {
  //   ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  // }
  static showSnackBar({bool type = false, String msg = ''}) {
    Get.snackbar(type ? 'Success' : 'Error', msg,
        // snackPosition: type ? SnackPosition.TOP : SnackPosition.BOTTOM,
        snackPosition: SnackPosition.TOP,
        colorText: type ? Colors.white : Colors.black,
        backgroundColor: type ? Colors.green : null);
  }

  static platform() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else {
      return 'NotDefine';
    }
  }

  static showLoaderAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
  }

  static showLoading(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColor.orange,
        ),
      ),
    );
  }

  static showError(String msg) {
    return Container(
        constraints: BoxConstraints.expand(height: 0.4.sh),
        child: Center(child: Content(data: msg, size: 20.h)));
  }

  static bool isEmail(String email) {
    String r =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(r);

    return !regExp.hasMatch(email);
  }

  static bool isPhone(String phone) {
    // String r = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    String r = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

    RegExp regExp = new RegExp(r);

    return !regExp.hasMatch(phone);
  }

  static bool validateEmail(TextEditingController value, BuildContext context) {
    if (value.text.isEmpty) {
      Utils.toastMessage("Please enter your email address", context);
      return false;
    } else if (Utils.isEmail(value.text)) {
      Utils.toastMessage("Please enter a valid email address", context);
      return false;
    } else {
      return true;
    }
  }

  static bool validatePhone(
      TextEditingController value, String type, BuildContext context) {
    if (value.text.isEmpty) {
      Utils.toastMessage("Please enter your $type number", context);
      return false;
    } else if (Utils.isPhone(value.text)) {
      Utils.toastMessage("Please enter a valid $type Number", context);
      return false;
    } else if (value.text.length < 8) {
      Utils.toastMessage(
          "$type Number length should be greater than 8 digits", context);
      return false;
    } else if (value.text.length > 15) {
      Utils.toastMessage(
          "$type Number length should be less than 15 digits", context);
      return false;
    } else {
      return true;
    }
  }

  static bool validatePassword(
      TextEditingController value, BuildContext context) {
    if (value.text.isEmpty) {
      Utils.toastMessage("Please enter your password", context);
      return false;
    } else if (value.text.length < 8) {
      Utils.toastMessage("Password should be greater than 8 digits", context);
      return false;
    } else if (value.text.length > 16) {
      Utils.toastMessage("Password length should be less than 16", context);
      return false;
    } else {
      return true;
    }
  }

  static bool validateNewPassword(
      TextEditingController value, BuildContext context) {
    if (value.text.isEmpty) {
      Utils.toastMessage("Enter your New password", context);
      return false;
    } else if (value.text.length < 8) {
      Utils.toastMessage("Password should be greater than 8 digits", context);
      return false;
    } else if (value.text.length > 16) {
      Utils.toastMessage("Password length should be less than 16", context);
      return false;
    } else {
      return true;
    }
  }

  static bool validateExistingPassword(
      TextEditingController value, BuildContext context) {
    if (value.text.isEmpty) {
      Utils.toastMessage("Please enter your password", context);
      return false;
    } else if (value.text.length < 8) {
      Utils.toastMessage("Current password is incorrect", context);
      return false;
    } else if (value.text.length > 16) {
      Utils.toastMessage("Current password is incorrect", context);
      return false;
    } else {
      return true;
    }
  }

  static bool validateConfirmPassword(TextEditingController value1,
      TextEditingController value2, BuildContext context) {
    if (value2.text.isEmpty) {
      Utils.toastMessage("Please enter Confirm Password", context);
      return false;
    } else if (value1.text != value2.text) {
      Utils.toastMessage("Password does not match", context);
      return false;
    } else {
      return true;
    }
  }

  static bool validate(TextEditingController value, String type) {
    if (value.text.isEmpty) {
      Utils.showSnackBar(type: false, msg: "Please enter your $type");
      return false;
    } else {
      return true;
    }
  }

  static bool isFullName(String name) {
    String r = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(r);

    return !regExp.hasMatch(name);
  }

  static bool validateFullName(TextEditingController value, String type) {
    if (value.text.isEmpty) {
      Utils.showSnackBar(type: false, msg: "Please enter $type name");
      return false;
    } else if (isFullName(value.text)) {
      Utils.showSnackBar(
          type: false, msg: "Please enter a valid $type full name");
      return false;
    } else {
      return true;
    }
  }

  static bool validateBirthDay(DateTime? dateTime, BuildContext context) {
    if (dateTime == null) {
      Utils.toastMessage("Please select Date of Birth", context);

      return false;
    } else if (dateTime.add(Duration(days: 365 * 18)).isAfter(DateTime.now())) {
      Utils.toastMessage("You should be at least 18 year old", context);
      return false;
    } else {
      return true;
    }
  }

  // static String formattedTime({required int timeInSecond}) {
  //   int sec = timeInSecond % 60;
  //   int min = (timeInSecond / 60).floor();
  //   String minute = min.toString().length <= 1 ? "0$min" : "$min";
  //   String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  //   return "$minute : $second";
  // }

  static String formattedTime({required int timeInSecond}) {
    int hours = (timeInSecond / 3600).floor();
    int remainingSeconds = timeInSecond % 3600;
    int minutes = (remainingSeconds / 60).floor();
    int seconds = remainingSeconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return hours != 0
        ? "$hoursStr:$minutesStr:$secondsStr"
        : "$minutesStr:$secondsStr";
  }

  static double distanceInMile(int? distanceInMeter) {
    if (distanceInMeter == null) {
      return 0;
    } else {
      return distanceInMeter / 1609.344;
    }
  }

  // static double distanceInMile(String distance) {
  //   double distanceInDouble = 0.0;
  //   distance = distance.trim();

  //   if (distance.contains("mile")) {
  //     distanceInDouble = double.parse(distance.split(' ').first);
  //   } else if (distance.contains("km")) {
  //     distanceInDouble = double.parse(distance.split(' ').first) / 1.609344;
  //   } else if (distance.contains("m")) {
  //     distanceInDouble = double.parse(distance.split(' ').first) / 1609.344;
  //   }
  //   //// log("<<<<<<<<<<<<<<<dist#$distanceInDouble>>>>>>>>>of#$distance>>>>>>");
  //   return distanceInDouble;
  // }

  static double timeInMin(String time) {
    double timeInDouble = 0.0;
    time = time.trim();

    if (time.contains("mins")) {
      timeInDouble = double.parse(time.split(' ').first);
    } else if (time.contains("secs")) {
      timeInDouble = double.parse(time.split(' ').first) * 0.0166667;
    } else if (time.contains("hours")) {
      timeInDouble = double.parse(time.split(' ').first) * 60;
    }
    //// log("<<<<<<<<<<<<<<<time#$timeInDouble>>>>>>>>>of#$time>>>>>>");

    return timeInDouble;
  }

  static closeKeyBoard(context) {
    FocusScope.of(context).unfocus();
  }

  // static Future<void> openDialer({required String number}) async {
  //   final Uri uri = Uri(scheme: 'tel', path: number);
  //   if (await url_launcher.canLaunchUrl(uri)) {
  //     await url_launcher.launchUrl(uri);
  //   }
  // }

  // static Future<void> launchUrl({required String url}) async {
  //   if (await url_launcher.canLaunchUrl(Uri.parse(url))) {
  //     await url_launcher.launchUrl(Uri.parse(url));
  //   }
  // }

  // static Future<void> logOut() async {
  //   if (isCaptain) {
  //     final captainHomeViewModel = Get.put(CaptainHomeViewModel());
  //     captainHomeViewModel.exitSocket();
  //   } else {
  //     final curaHomeViewModel = Get.put(CuraHomeViewModel());
  //     curaHomeViewModel.exitSocket();
  //   }
  //   await UserDataModel.data.clear();
  //   Get.offAll(() => SelectUser());
  //   // log("LogOut Successfully",name: "Logout");
  // }

  static Future<void> saveToLocal(
      {required String key, required String value}) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String> getFromLocal({required String key}) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(
          key: key,
        ) ??
        '';
  }

  static String timeStamp(DateTime dateTime) {
    final now = DateTime.now().toUtc();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
