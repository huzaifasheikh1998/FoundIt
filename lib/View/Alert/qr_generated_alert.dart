import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Model/order_details_initial_param.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/View/Home/OrderDetails.dart';
import 'package:foundit/ViewModel/order_detail_view_model.dart';
import 'package:foundit/main.dart';
import 'package:get/get.dart';

qrGeneratedAlert(String img, String qrCodeId, BuildContext context) {
  return showDialog(
    barrierColor: Color(0xff273448).withOpacity(0.9),
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
                  // width: 1.sw,
                  // height: 400.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.transparent),
                  child: Column(
                    children: [
                      Container(
                        width: 177.w,
                        height: 177.h,
                        child: Image.network(
                          img,
                          // loadingBuilder: (context, child, loadingProgress) {
                          //   return Center(
                          //     child: Container(
                          //       height: 30,
                          //       width: 30,
                          //       child: CircularProgressIndicator(
                          //         color: Color(0xffEA8806),
                          //       ),
                          //     ),
                          //   );
                          // },
                        ),
                        // child: Image.asset(
                        //     'assets/images/Icon awesome-qrcode@2xx.png'),
                      ),
                      30.verticalSpace,
                      Container(
                        width: 228.w,
                        // height: 100.h,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Your QR Code is Ready to Print",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      26.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 150.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                border: Border.all(color: AppColor.orange),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Save",
                                      style: TextStyle(
                                        color: AppColor.orange,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed("/EnterYouAddressScreen");
                              Get.off(() => OrderDetailsScreen(
                                    orderDetailViewModel: orderDetailViewModel,
                                    orderDetailsInitialParam:
                                        OrderDetailsInitialParam(qrCodeId, img),
                                  ));
                            },
                            child: Container(
                              width: 150.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColor.orange,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Print",
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          );
        },
      );
    },
  );
}
