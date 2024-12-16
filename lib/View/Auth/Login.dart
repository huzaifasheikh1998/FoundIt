import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/resources/components/AuthTextField.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpassController = TextEditingController();
  bool isChecked = false;
  // bool isChec?ked2 = false;

  bool tick = false;
  bool pass = true;

  getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    useremailController.text = sp.getString("userEmail") ?? "";
    userpassController.text = sp.getString("userPassword") ?? "";
    if (useremailController.text.length > 0) {
      isChecked = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    20.verticalSpace,
                    Container(
                      width: 378.w,
                      height: 286.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius: BorderRadius.circular(150)),
                      child: Image.asset(
                        "assets/images/Mask Group 3@2x.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    30.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // width: 143.w,
                                // height: 43.h,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 32.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              4.verticalSpace,
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/SignupScreen');
                                },
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Login below or ',
                                            style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w200,
                                            )),
                                        TextSpan(
                                            text: 'Create an account',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffFFFFFF),
                                                decoration:
                                                    TextDecoration.underline)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              28.verticalSpace,
                              Names("Email"),
                              10.verticalSpace,
                              AuthTextField(
                                validator: (text) {
                                  final emailRegExp = RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  // if (!emailRegExp
                                  //     .hasMatch(useremailController.text)) {
                                  //   return 'Please enter valid email address';
                                  // }
                                },
                                controller: useremailController,
                                fontsiz: 15,
                                labelfont: 20,
                                widthh: 348.0.w,
                                hint: "Email",
                                isPassword: false,
                                labelText: "Password",
                              ),

                              19.verticalSpace,
                              Names("Password"),
                              9.verticalSpace,
                              AuthTextField(
                                validator: (text) {
                                  if (userpassController.text.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (text.length < 6) {
                                    return 'Password Must be 6 digits';
                                  }
                                },
                                controller: userpassController,
                                fontsiz: 15,
                                labelfont: 20,

                                widthh: 348.0.w,
                                hint: "Password",

                                isPassword: pass,
                                // suffixIcon: Icons.remove_red_eye,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    pass
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      pass = !pass;
                                    });
                                  },
                                ),
                              ),
                              // TexttField1(),
                              9.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // height: 20.h,
                                    // width: 210.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isChecked = !isChecked;
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 20.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white)),
                                            child: Icon(
                                              Icons.circle,
                                              size: 10.r,
                                              color: isChecked
                                                  ? Colors.white
                                                  : Colors.transparent,
                                            ),
                                            // child: Checkbox(
                                            //     side: AlwaysActiveBorderSide(),
                                            //     shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(10.r),
                                            //     ),
                                            //     checkColor: Colors.transparent,
                                            //     // activeColor: Color(0xffEA8806),
                                            //     fillColor:
                                            //         MaterialStatePropertyAll(
                                            //             isChecked
                                            //                 ? Color(0xffEA8806)
                                            //                 : Colors.white),
                                            //     value: isChecked,
                                            //     onChanged: (value) {
                                            //       setState(() {
                                            //         isChecked = value!;
                                            //         print(
                                            //             "===================> ischecked: $isChecked");
                                            //         print(
                                            //             "===================> value: $value");
                                            //       });
                                            //     }),
                                          ),
                                          5.horizontalSpace,
                                          Text(
                                            "Remember Me",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 0.17.sw.horizontalSpace,
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed("/ForgotPasswordScreen");
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          28.verticalSpace,
                          GestureDetector(
                            onTap: () async {
                              // print("object");
                              email =
                                  useremailController.text.trim().toString();
                              var data = {
                                "email": email.toString(),
                                "password":
                                    userpassController.text.trim().toString(),
                                "remember_me": 1,
                                "device_token": deviceToken,

                                // "deviceToken": "deviceToken",
                                // "deviceType": "android",
                              };
                              if (_formKey.currentState!.validate()) {
                                // email = useremailController.text.trim();

                                await ApiServices()
                                    .callLogin(context, data, isChecked);
                              }
                              ;
                              // final bottomcontroller = Get.put(BottomController());
                              // bottomcontroller.navBarChange(0);
                              // Get.to(() => MainScreen());
                            },
                            child: Container(
                              width: 350.w,
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
                                      "Login",
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
                    20.verticalSpace,
                  ],
                ),
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

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(_) => const BorderSide(
        color: Colors.white,
        width: 4,
      );
}
