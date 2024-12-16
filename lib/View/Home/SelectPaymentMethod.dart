import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/BottomController.dart';
import '../../NavBar/Navbar.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodStateScreen();
}

class _SelectPaymentMethodStateScreen extends State<SelectPaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Select Payment Method",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.toNamed("/AddCardScreen");
              },
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffF5A336),
                      Color(0xffF09722),
                    ],
                  ),
                ),
                child: Image.asset(
                  "assets/images/Icon awesome-plus@2x.png",
                  scale: 4,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                120.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.06),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10.r,
                          )),
                      child: Image.asset(
                        "assets/images/Group 93@2x.png",
                        scale: 2,
                      ),
                    ),
                    Container(
                      width: 120.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.orange.withOpacity(0.06),
                          //     spreadRadius: 3,
                          //     blurRadius: 2,
                          //     offset: Offset(0, 1), // changes position of shadow
                          //   ),
                          // ],
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10.r,
                          )),
                      child: Image.asset(
                        "assets/images/580b57fcd9996e24bc43c530@2x.png",
                        scale: 2,
                      ),
                    ),
                    Container(
                      width: 120.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.orange.withOpacity(0.06),
                          //     spreadRadius: 3,
                          //     blurRadius: 2,
                          //     offset: Offset(0, 1), // changes position of shadow
                          //   ),
                          // ],
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10.r,
                          )),
                      child: Image.asset(
                        "assets/images/Group 95@2x.png",
                        scale: 2,
                      ),
                    )
                  ],
                ),
                21.verticalSpace,
                Container(
                  width: 389,
                  height: 223,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.2),
                        spreadRadius: 9,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/Group 448@2x.png",
                    // fit: BoxFit.fill,
                  ),
                ),
                29.verticalSpace,
                Price("Price", "\$50"),
                10.verticalSpace,
                Price("Price", "\$2.5"),
                10.verticalSpace,
                Price("Price", "\$25.50"),
                70.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Function1();
                    // Get.toNamed("/SelectPaymentMethodScreen");
                  },
                  child: Container(
                    width: 389.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(01),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xffF5A336),
                          Color(0xffF09722),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Confirm",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Price(
    txt,
    txt1,
  ) {
    return Container(
      width: 389.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff00000029).withOpacity(0.06),
            spreadRadius: 9,
            blurRadius: 9,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txt,
              style: TextStyle(
                color: Color(0xff667080),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              txt1,
              style: TextStyle(
                color: Color(0xffF09722),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Function1() {
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
                  width: 320.w,
                  height: 320.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 122.w,
                        height: 139.h,
                        child: Image.asset(
                            'assets/images/Mask-Group-23-2x-removebg-preview.png'),
                      ),
                      4.verticalSpace,
                      Container(
                        width: 300.w,
                        height: 70.h,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Congratulations",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 33.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Payment done successfully",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      25.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          final bottomcontroller = Get.put(BottomController());
                          bottomcontroller.navBarChange(1);
                          Get.to(() => MainScreen());
                        },
                        child: Container(
                          width: 320.w,
                          height: 51.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xffFFB24B),
                                Color(0xffEA8806),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Go Back To Home",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
}
