import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:get/get.dart';

import '../../services/api_services.dart';

class AddNewMemberScreen extends StatefulWidget {
  const AddNewMemberScreen({super.key});

  @override
  State<AddNewMemberScreen> createState() => _AddNewMemberStateScreen();
}

class _AddNewMemberStateScreen extends State<AddNewMemberScreen> {
  TextEditingController memberEmailController = TextEditingController();
  TextEditingController memberNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add New Member",
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
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                70.verticalSpace,
                Names("Name"),
                6.verticalSpace,
                TexttField(),
                6.verticalSpace,
                Names("Email"),
                6.verticalSpace,
                TexttField2(),
                30.verticalSpace,
                GestureDetector(
                  onTap: () async {
                    log("tapppedddddddddddddddd");
                    var data = {
                      "email": memberEmailController.text,
                      "name": memberNameController.text,
                    };
                    await ApiServices().addMember(context, data);
                    Function1();
                  },
                  child: Container(
                    width: 388.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffF09722).withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 6,
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
                            "Add Now",
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
            color: Color(0xff667080),
            fontSize: 14.sp,
          ),
        )
      ],
    );
  }

  TexttField() {
    return Container(
      width: 388.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff7E91B1), width: 1.sp),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextFormField(
        controller: memberNameController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 30),
          hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }

  TexttField2() {
    return Container(
      width: 388.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff7E91B1), width: 1.sp),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextFormField(
        controller: memberEmailController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 30),
          hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
          border: InputBorder.none,
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
