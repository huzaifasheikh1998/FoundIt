import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/ViewModel/setting_screen_view_model.dart';
import 'package:foundit/services/api_services.dart';
// import 'package:foundit/Auth/Login.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isChecked = false;
  bool isChecked2 = false;
  var switchnot = false;

final settingScreenViewModel = Get.put(SettingScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            final bottomcontroller = Get.put(BottomController());
            bottomcontroller.navBarChange(0);
            Get.to(() => MainScreen());
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 56.w,
              height: 38.h,
              child: Image.asset("assets/images/Group 331@2x.png"),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                20.verticalSpace,
                Cupertino(),
                10.verticalSpace,
                Drop("About App", () {
                  Get.toNamed("/AboutAppScreen");
                }),
                10.verticalSpace,
                Drop("Privacy Policy", () {
                  Get.toNamed("/PrivacyPolicyScreen");
                }),
                10.verticalSpace,
                Drop("Terms & Condiciton", () {
                  Get.toNamed("/TermsAndCondicitonScreen");
                }),
                10.verticalSpace,
                Drop("Rate This App", () {
                  Get.toNamed("/RateThisAppScreen");
                }),
                10.verticalSpace,
                Drop("Add Member", () {
                  Get.toNamed("/AddNewMemberScreen");
                }),
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Function1();
                  },
                  child: Container(
                      width: 396.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border:
                            Border.all(color: Color(0xffD5DEEB), width: 1.sp),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                "assets/images/Path 238@2x.png",
                                scale: 2,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Cupertino() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        // border: Border.all(color: Color(0xffD5DEEB), width: 1.sp),
        borderRadius: BorderRadius.circular(30.r),
      ),
      width: 396.w,
      height: 60.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   child: Image.asset(
            //     "assets/images/Icon ionic-ios-notifications.png",
            //     scale: 5,
            //   ),
            // ),
            // 20.horizontalSpace,
            Text(
              "Notifications",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            // 156.horizontalSpace,
            Transform.scale(
              scale: 0.7,
              child: GetBuilder(
                init: settingScreenViewModel,
                builder: (_value) {
                  return CupertinoSwitch(
                    value: _value.notificationStatus,
                  
                    activeColor: Color(0xffEA8806),
                    
                    onChanged: (value) {
                    _value.toggleNotificationStatus(value, true);
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Drop(
    txt,
    // Img,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 396.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(color: Color(0xffD5DEEB), width: 1.sp),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: [
                // Container(
                //   child: Image.asset(
                //     Img,
                //     scale: 5,
                //   ),
                // ),
                20.horizontalSpace,
                Text(
                  txt,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Function1() {
    return showDialog(
      barrierDismissible: true,
      // barrierColor: Colors.white,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xff000000B8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
              contentPadding: EdgeInsets.all(0),
              actionsPadding: EdgeInsets.all(0),
              actions: [
                Container(
                  width: 0.744.sw,
                  height: 0.246.sh,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xffFFFFFF)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0.024.sh),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // 0.023.sh.verticalSpace,
                        Text(
                          textAlign: TextAlign.center,
                          "Are you sure you\nwant to logout?",
                          style: TextStyle(
                              fontSize: 22.sp, color: Color(0xff2C2C2C)),
                        ),
                        Container(
                          height: 0.054.sh,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    // width: 159.w,
                                    // height: 45.h,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffEA8806)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0.r),
                                        bottomLeft: Radius.circular(9.r),
                                      ),
                                      color: Color(0xffFFFFFF),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style:
                                            TextStyle(color: Color(0xffEA8806)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   color: Color(0xffDCE3EE),
                              //   height: 64.h,
                              //   width: 1.6.w,
                              // ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    print("ABCDDD${AuthToken.toString()}");
                                    var data = {};
                                    await ApiServices()
                                        .callLogout(context, data);
                                    // Get.toNamed("/LoginScreen");
                                  },
                                  child: Container(
                                    // width: 158.1.w,
                                    // height: 45.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(0.r),
                                        bottomRight: Radius.circular(9.r),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xffFBA739),
                                          Color(0xffEA8806),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Logout",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
