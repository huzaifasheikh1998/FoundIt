import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/Data/network/network_api_services_dio.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/service/notification_services.dart';
import 'package:foundit/services/local_storage_service.dart';
import 'package:get/get.dart';

getToken() async {
  deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
  Utils.logInfo(deviceToken, name: "Device Token");
  // SharedPreferences _prefs = await SharedPreferences.getInstance();
  // _prefs.setString("fcmToken", deviceToken.toString());
  // final storage = new FlutterSecureStorage(
  //     aOptions: AndroidOptions(encryptedSharedPreferences: true),
  //     iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

  // await storage.write(key: 'fcmToken', value: deviceToken);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final notificationServices = FireBaseNotificationServices();

  void initState() {
    getToken();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    // notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    super.initState();
    // Timer(Duration(seconds: 3), () => Get.toNamed('/PRELOGINScreen'));
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log("splash called");
    }

    return GestureDetector(
      onTap: () {
        // Get.toNamed("/SocialLoginScreen");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffEA8806),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Group 440@2x.png',
            ),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      18.verticalSpace,
                      Container(
                        width: 322.w,
                        height: 69.h,
                        child: Image.asset("assets/images/Group 291@2x.png"),
                      ),
                      40.verticalSpace,
                      ClipOval(
                        clipBehavior: Clip.none,
                        child: Container(
                          width: 299.w,
                          height: 407.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.w,
                              )),
                          child: Image.asset(
                            "assets/images/Mask Group 2@2x.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          5.horizontalSpace,
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          5.horizontalSpace,
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Container(
                        width: 500.w,
                        height: 80.h,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      11.verticalSpace,
                      Container(
                        width: 374.w,
                        height: 52.h,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend felis",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w200,
                            color: Color(0xffFFFFFF).withOpacity(0.7),
                          ),
                        ),
                      ),
                      19.verticalSpace,
                      GestureDetector(
                        onTap: () async {
                          if (kDebugMode) {
                            log("splash next tapped");
                          }

                          // Get.toNamed("/PreLoginScreen");

                          if (Platform.isIOS) {
                            await deletePreviousStorage();
                          }

                          await User().init().then((value)async {
                            if (User.data.userEmail.isNotEmpty) {
                              AuthToken = User.data.apiToken;
                              NetworkApiServices.ins
                                  .updateAuthDio(User.data.apiToken);
                              final bottomcontroller =
                                  Get.put(BottomController());
                              bottomcontroller.navBarChange(0);
                              Get.offAll(() => MainScreen());
                            } else {
                              Get.toNamed("/PreLoginScreen");
                            }
                          }).onError((error, stackTrace) {
                            if (kDebugMode) {
                              log("$error");
                            }
                          });
                        },
                        child: Container(
                          width: 100.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            // gradient: LinearGradient(
                            //   begin: Alignment.bottomRight,
                            //   end: Alignment.bottomLeft,
                            //   colors: [
                            //     Color(0xff1CC8FB),
                            //     Color(0xff004DF2),
                            //   ],
                            // ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Color(0xffEA8806),
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
