import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:foundit/Utils/app_assets.dart';
import 'package:get/get.dart';

resultAlert(
    {required bool result,
    required String title,
    required String msg,
    required BuildContext context}) {
  return showDialog(
    barrierDismissible: false,
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
                width: 360.h,
                height: 360.h,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xffFFFFFF)),
                child: Column(children: [
                  Image.asset(
                    result ? AppAsset.thumbsUp : AppAsset.thumbsDown,
                    height: 139.h,
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Center(
                    child: Text(
                      msg,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Color(0xff707070),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  28.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      if (result) {
                        Get.offAll(() => MainScreen());
                      } else {
                        Get.back();
                      }
                    },
                    child: Container(
                      width: 290.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Color(0xffEA8806),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          "Go Back To Home",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

resulCanceltAlert(
    {required bool result,
    required String title,
    required String msg,
    required BuildContext context}) {
  return showDialog(
    barrierDismissible: false,
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
            insetPadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            actionsPadding: EdgeInsets.all(0),
            actions: [
              Container(
                width: 360.h,
                // height: 360.h,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xffFFFFFF)),
                child: Column(children: [
                  Image.asset(
                    result ? AppAsset.thumbsUp : AppAsset.thumbsDown,
                    height: 139.h,
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Center(
                    child: SizedBox(
                      width: Get.width * .6,
                      child: Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff707070),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  28.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.close(2);
                    },
                    child: Container(
                      width: Get.width,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.w),
                            bottomRight: Radius.circular(10.w)),
                        color: Color(0xffEA8806),
                      ),
                      child: Center(
                        child: Text(
                          "Go Back",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
