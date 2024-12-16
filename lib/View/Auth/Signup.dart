import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/View/Auth/Login.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/resources/components/AuthTextField.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmpasswordController = TextEditingController();
  bool pass = true;
  bool pass1 = true;
  bool pass2 = true;
  bool _value = false;
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
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  40.verticalSpace,
                  Row(
                    children: [
                      Container(
                        width: 150.w,
                        height: 31.h,
                        child: Image.asset("assets/images/Group 291@2x.png"),
                      ),
                    ],
                  ),
                  50.verticalSpace,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/LoginScreen");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // width: 143.w,
                                  // height: 43.h,
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    "Signup",
                                    style: TextStyle(
                                        fontSize: 32.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                11.verticalSpace,
                                GestureDetector(
                                  // onTap: () {
                                  //   Get.toNamed('/SignupScreen');
                                  // },
                                  child: Container(
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    'Enter your account details below or  ',
                                                style: TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w200,
                                                )),
                                            TextSpan(
                                                text: 'Log in',
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffFFFFFF),
                                                    decoration: TextDecoration
                                                        .underline)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          46.verticalSpace,
                          Names("Name"),
                          9.verticalSpace,
                          AuthTextField(
                            validator: (text) {
                              final fullNameRegExp = RegExp(r'^[A-Za-z\s]+$');
                              if (text == null || text.isEmpty) {
                                return 'Please enter full name';
                              }
                              if (!fullNameRegExp
                                  .hasMatch(usernameController.text)) {
                                return 'Please enter a valid name';
                              }
                            },
                            controller: usernameController,
                            fontsiz: 15,
                            labelfont: 20,
                            widthh: 348.0.w,
                            hint: "Full Name",
                            isPassword: false,
                            labelText: "Full Name",
                          ),
                          23.verticalSpace,
                          Names("Email"),
                          9.verticalSpace,
                          AuthTextField(
                            validator: (text) {
                              final emailRegExp = RegExp(
                                  r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,}$');
                              if (text == null || text.isEmpty) {
                                return 'Please enter your email address';
                              }
                              if (!emailRegExp
                                  .hasMatch(useremailController.text)) {
                                return 'Please enter valid email address';
                              }
                            },
                            controller: useremailController,
                            fontsiz: 15,
                            labelfont: 20,
                            widthh: 348.0.w,
                            hint: "Email",
                            isPassword: false,
                            // labelText: "Password",
                          ),
                          // TexttField(),
                          23.verticalSpace,
                          Names("Password"),
                          9.verticalSpace,
                          AuthTextField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (text.length < 6) {
                                return 'Password Must be 6 characters';
                              }
                            },
                            controller: passwordController,
                            fontsiz: 15,
                            labelfont: 20,

                            widthh: 348.0.w,
                            hint: "Passsword",

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
                          ),
                          23.verticalSpace,
                          Names("Repeat Password"),
                          9.verticalSpace,
                          AuthTextField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (text.length < 6 ||
                                  passwordController.text !=
                                      ConfirmpasswordController.text) {
                                return ' Password does not match';
                              }
                            },
                            controller: ConfirmpasswordController,
                            fontsiz: 15,
                            labelfont: 20,

                            widthh: 348.0.w,
                            hint: "Confirm New Password",

                            isPassword: pass2,
                            // suffixIcon: Icons.remove_red_eye,
                            suffixIcon: IconButton(
                              icon: Icon(
                                pass2 ? Icons.visibility_off : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  pass2 = !pass2;
                                });
                              },
                            ),
                          ),
                          23.verticalSpace,
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _value = !_value;
                                  });
                                },

                                child: Container(
                                  width: 25,
                                  child: Checkbox(
                                      side: AlwaysActiveBorderSide(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      checkColor: Colors.transparent,
                                      // activeColor: Color(0xffEA8806),
                                      fillColor: MaterialStatePropertyAll(_value
                                          ? Color(0xffEA8806)
                                          : Colors.white),
                                      value: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                          print(
                                              "===================> ischecked: $_value");
                                          print(
                                              "===================> value: $value");
                                        });
                                      }),
                                ),
                                // child: Container(
                                //   height: 25,
                                //   width: 25,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     // border: Border.all(color: _value ? Color(0xff6A6A6A) : Color(0xff6A6A6A), width: 1),
                                //   ),
                                //   child: Icon(
                                //     Icons.circle_rounded,
                                //     color: _value == true
                                //         ? Colors.white
                                //         : Color(0xff303030),
                                //     size: 18,
                                //   ),
                                // ),
                              ),
                              Container(
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '  I agree to the  ',
                                            style: TextStyle(
                                              color: Color(0xffFFFFFF)
                                                  .withOpacity(0.7),
                                              fontSize: 17.sp,
                                              // fontWeight: FontWeight.w200,
                                            )),
                                        TextSpan(
                                            text:
                                                'Terms of service & \n  Privacy policy',
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffFFFFFF),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          28.verticalSpace,
                          GestureDetector(
                            onTap: () async {
                              email = useremailController.text.trim();

                              if (_formKey.currentState!.validate()) {
                                var data = {
                                  'email': email.toString(),
                                  'password': passwordController.text.trim(),
                                  'name': usernameController.text.trim(),
                                  'device_token': 'ssasss',
                                  // 'deviceType': 'android'
                                };
                                _value == true
                                    ? await ApiServices()
                                        .callregister(context, data)
                                    : Get.snackbar(
                                        'Please accept agree to Terms of service & Privacy policy',
                                        '');
                              } else {
                                print(email.toString());
                              }
                              ;
                              // Get.toNamed("/PhoneVerificationScreen");
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
                                      "Signup",
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
                    ],
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
            color: Color(0xffFFFFFF),
            fontSize: 14.sp,
          ),
        )
      ],
    );
  }
}
