import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

mySaveQrAlert(String imgUrl, BuildContext context) {
  return showDialog(
    // barrierColor: Color(0xff273448).withOpacity(0.9),
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
                width: 320.h,
                height: 320.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              child: Image.asset(
                                "assets/images/Icon ionic-ios-close@2x.png",
                                color: Color(0xff667080),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                          height: 250.h,
                          width: 250.h,
                          child: Image.network(
                            imgUrl,
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
