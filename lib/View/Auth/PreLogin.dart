import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginStateScreen();
}

class _PreLoginStateScreen extends State<PreLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEA8806),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                135.verticalSpace,
                Row(
                  children: [
                    Container(
                      width: 150.w,
                      height: 31.h,
                      child: Image.asset("assets/images/Group 291@2x.png"),
                    ),
                  ],
                ),
                80.verticalSpace,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: 143.w,
                          // height: 43.h,
                          child: Text(
                            textAlign: TextAlign.left,
                            "Pre Login",
                            style: TextStyle(
                                fontSize: 32.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        4.verticalSpace,
                        Container(
                          child: Text(
                            textAlign: TextAlign.left,
                            "Select your login option",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xffFFFFFF).withOpacity(0.7),
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                40.verticalSpace,
                prelongins("assets/images/images@2x.png", "Login with Email"),
                15.verticalSpace,
                prelongins(
                    "assets/images/images-1@2x.png", "Login with Facebook"),
                15.verticalSpace,
                prelongins(
                    "assets/images/download (2)@2x.png", "Login with Google"),
                15.verticalSpace,
                prelongins(
                    "assets/images/images (1)@2x.png", "Login with Apple"),
                200.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/SignupScreen');
                  },
                  child: Container(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w200,
                                )),
                            TextSpan(
                                text: 'Signup',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffFFFFFF),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  prelongins(
    Img,
    Txt,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/LoginScreen");
      },
      child: Container(
        width: 355.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Color(0xffEEF1F4),

          // boxShadow: [
          //   BoxShadow(
          //     // color: Colors.grey.withOpacity(0.5),
          //     // spreadRadius: 5,
          //     // blurRadius: 0,
          //     offset: Offset(0, 0), // changes position of shadow
          //   ),
          // ],
          // border: Border.all(color: Colors.white, width: 3.sp),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 17),
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  child: Image.asset(
                    Img,
                  ),
                ),
              ),
              // SizedBox(width: 18.h),
              Container(
                width: 200,
                child: Text(
                  Txt,
                  style: TextStyle(color: Color(0xffEA8806), fontSize: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
