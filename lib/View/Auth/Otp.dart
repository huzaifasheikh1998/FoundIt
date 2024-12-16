import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _ForgotPasswordStateScreen();
}

class _ForgotPasswordStateScreen extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String otp = "";
  String currentText = "";
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
            child: Form(
              key: _formKey,
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
                            child: Text(
                              textAlign: TextAlign.left,
                              "One Time Password",
                              style: TextStyle(
                                  fontSize: 31.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          4.verticalSpace,
                          Container(
                            child: Text(
                              textAlign: TextAlign.left,
                              "Enter your OTP",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xffFFFFFF).withOpacity(0.7),
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: true,
                    hintStyle: TextStyle(color: Colors.white),
                    textStyle: TextStyle(color: Colors.white),
                    obscuringCharacter: '*',
                    //
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (textEditingController.text.isEmpty) {
                        return 'Please enter full code';
                      }
                      if (v!.length < 4) {
                        return "Please enter valid otp";
                      }
                    },
                    errorTextSpace: 30.h,
                    pinTheme: PinTheme(
                      fieldOuterPadding: EdgeInsets.symmetric(horizontal: 0),
                      selectedFillColor: Colors.transparent,
                      selectedColor: Colors.orange,
                      disabledColor: Colors.white,
                      inactiveColor: Colors.orange,
                      inactiveFillColor: Color(0xffFFFFFF).withOpacity(0.3),
                      activeColor: Colors.orange,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.transparent,
                    ),
                    cursorColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    // boxShadows: const [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   )
                    // ],
                    // onCompleted: ("n")
                    // async {
                    //   debugPrint("Completed");

                    //   var data = {"email": email, "otp": textEditingController.text, "deviceToken": deviceToken, "deviceType": "android"};

                    //   if (textEditingController.text.length == 4) {
                    //     await ApiServices().verifyotp(context, data);
                    //   }
                    //   // Get.to(() => VerificationScreen());
                    // },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  30.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      // email = textEditingController.text.trim();
                      var data = {
                        "email": email,
                        "otp": textEditingController.text.trim(),
                      };
                      if ((_formKey.currentState!.validate())) {
                        await ApiServices().verifyForgetotp(context, data);
                      }
                      // Get.toNamed("/CreateNewPaswordScreen");
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
                  230.h.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      // Get.to(() => SignupScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Code didn\'t receive?',
                        ),
                        2.horizontalSpace,
                        GestureDetector(
                          onTap: () async {
                            var data = {
                              "email": email.toString(),
                            };
                            await ApiServices()
                                .callforgetPassword1(context, data);
                          },
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Names(
//   txt,
// ) {
//   return Row(
//     children: [
//       Text(
//         txt,
//         style: TextStyle(
//           fontWeight: FontWeight.w200,
//           color: Color(0xffFFFFFF).withOpacity(0.7),
//           fontSize: 14.sp,
//         ),
//       )
//     ],
//   );
// }

// TexttField() {
//   return Container(
//     width: 348.w,
//     height: 55.h,
//     decoration: BoxDecoration(
//       // color: Colors.white,
//       border: Border.all(color: Color(0xffFFFFFF), width: 1.sp),
//       borderRadius: BorderRadius.circular(10.r),
//     ),
//     child: TextFormField(
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(left: 30),
//         hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
//         border: InputBorder.none,
//       ),
//     ),
//   );
// }
// }
