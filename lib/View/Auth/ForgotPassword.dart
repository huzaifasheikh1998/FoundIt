import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/resources/components/AuthTextField.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordStateScreen();
}

class _ForgotPasswordStateScreen extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController Forgotemail = TextEditingController();
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
                            // width: 143.w,
                            // height: 43.h,
                            child: Text(
                              textAlign: TextAlign.left,
                              "Forgot Password?",
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
                              "Enter your email",
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
                  Names("Email"),
                  9.verticalSpace,
                  AuthTextField(
                    validator: (text) {
                      final emailRegExp =
                          RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (text == null || text.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!emailRegExp.hasMatch(Forgotemail.text)) {
                        return 'Please enter valid email address';
                      }
                    },
                    controller: Forgotemail,
                    fontsiz: 15,
                    labelfont: 20,

                    widthh: 350.0.w,
                    // hint: "Email",

                    isPassword: false,
                    // suffixIcon: Icons.remove_red_eye,
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     pass ? Icons.visibility_off : Icons.visibility,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       pass = !pass;
                    //     });
                    //   },
                    // ),
                    labelText: "Password",

                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: Icon(
                    //     Icons.email,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),

                    //   // FaIcon(
                    //   //   FontAwesomeIcons.userLarge,
                    //   //   color: Color(0xff0C0D26).withOpacity(0.4),
                    //   //   size: 20,
                    //   // ),
                    // ),
                  ),
                  // TexttField(),
                  30.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      email = Forgotemail.text.trim();
                      if (_formKey.currentState!.validate()) {
                        var data = {
                          "email": email.toString(),
                        };
                        await ApiServices().callforgetPassword(context, data);
                      }
                      // Get.toNamed("/OtpScreen");
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
}
