import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _ForgotPasswordStateScreen();
}

class _ForgotPasswordStateScreen extends State<PhoneVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEA8806),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 56.w,
              height: 38.h,
              child: Image.asset("assets/images/Group 335@2x.png"),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                78.verticalSpace,
                Row(
                  children: [
                    Container(
                      width: 150.w,
                      height: 31.h,
                      child: Image.asset("assets/images/Group 291@2x.png"),
                    ),
                  ],
                ),
                166.verticalSpace,
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
                            "Phone Verification",
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
                            "Enter your phone number",
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
                30.verticalSpace,
                Names("Phone Number"),
                9.verticalSpace,
                TexttField(),
                30.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/SignupOtpScreen");
                  },
                  child: Container(
                    width: 345.w,
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
                            "Confirm",
                            style: TextStyle(
                              color: Color(0xffEA8806),
                              fontSize: 16.sp,
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
          ),
        ),
      ),
    );
  }

  Names(
    txt,
  ) {
    return Row(
      children: [
        Text(
          txt,
          style: TextStyle(
            fontWeight: FontWeight.w200,
            color: Color(0xffFFFFFF).withOpacity(0.7),
            fontSize: 14.sp,
          ),
        )
      ],
    );
  }

  TexttField() {
    return Container(
      width: 348.w,
      height: 55.h,
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border.all(color: Color(0xffFFFFFF), width: 1.sp),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 30),
            hintStyle: TextStyle(
                color: Color(0xffFFFFFF).withOpacity(0.7), fontSize: 16.sp),
            border: InputBorder.none,
            hintText: "+1 (555) 555-1234"),
      ),
    );
  }
}
