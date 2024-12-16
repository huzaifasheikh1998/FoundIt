import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/resources/components/AuthTextField.dart';
import 'package:get/get.dart';

class CreateNewPaswordScreen extends StatefulWidget {
  const CreateNewPaswordScreen({super.key});

  @override
  State<CreateNewPaswordScreen> createState() => _ForgotPasswordStateScreen();
}

class _ForgotPasswordStateScreen extends State<CreateNewPaswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool pass = true;
  bool pass1 = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController repeatpassword = TextEditingController();

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
                              "Create New Pasword",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  Names("Enter New Password"),
                  9.verticalSpace,
                  AuthTextField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (text.length < 6) {
                        return 'Password Must be 6 digits';
                      }
                    },
                    controller: newpassword,
                    fontsiz: 15,
                    labelfont: 20,

                    widthh: 350.0.w,
                    hint: "Password",

                    isPassword: pass,
                    // suffixIcon: Icons.remove_red_eye,
                    suffixIcon: IconButton(
                      icon: Icon(
                        pass ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                    ),
                    // labelText: "Password",
                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.all(15), child: Icon(Icons.remove_red_eye),
                    //   //  FaIcon(
                    //   //   FontAwesomeIcons.lock,
                    //   //   color: Color(0xff9D9EA8),
                    //   //   size: 20,
                    //   // ),
                    // ),

                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: FaIcon(
                    //     FontAwesomeIcons.lock,
                    //     color: Color(0xff0C0D26).withOpacity(0.4),
                    //     size: 20,
                    //   ),
                    // ),
                  ),
                  30.verticalSpace,
                  Names("Repeat Password"),
                  9.verticalSpace,
                  AuthTextField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (text.length < 6 ||
                          newpassword.text != repeatpassword.text) {
                        return ' Password does not match';
                      }
                    },
                    controller: repeatpassword,
                    fontsiz: 15,
                    labelfont: 20,

                    widthh: 350.0.w,
                    hint: "Confirm Password",

                    isPassword: pass1,
                    // suffixIcon: Icons.remove_red_eye,
                    suffixIcon: IconButton(
                      icon: Icon(
                        pass1 ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          pass1 = !pass1;
                        });
                      },
                    ),
                  ),
                  30.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        var data = {
                          "email": email,
                          "new_password": newpassword.text.trim(),
                        };
                        await ApiServices().callresetPassword(context, data);
                      }

                      // Get.toNamed("/LoginScreen");
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

  TexttField1() {
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
            contentPadding: EdgeInsets.only(left: 20, top: 13),
            hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
            border: InputBorder.none,
            suffixIcon: Container(
              width: 16.w,
              height: 11.h,
              child: Image.asset(
                "assets/images/Group 2@2x.png",
                scale: 1.8,
              ),
            )),
      ),
    );
  }
}
