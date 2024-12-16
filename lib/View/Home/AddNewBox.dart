import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/Controller/BottomController.dart';
// import 'package:foundit/HomeScreens/Home.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/components/AuthTextField.dart';

class AddNewBoxScreen extends StatefulWidget {
  const AddNewBoxScreen({super.key});

  @override
  State<AddNewBoxScreen> createState() => _AddNewItemStateScreen();
}

class _AddNewItemStateScreen extends State<AddNewBoxScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final picker = ImagePicker();
  File? imageFile;

  void _getFromGallery() async {
    final result = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null)
      setState(() {
        imageFile = File(result.path);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add New Box",
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      _getFromGallery();
                    },
                    child: imageFile != null
                        ? Container(
                            width: 390.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: Colors.white,
                              image: DecorationImage(
                                image: FileImage(imageFile!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(14.r),
                              dashPattern: [4, 4],
                              color: Color(0xffC5C6C7),
                              strokeWidth: 2.w,
                              child: Container(),
                            ),
                          )
                        : Container(
                            width: 390.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: Colors.white,
                            ),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(14.r),
                              dashPattern: [4, 4],
                              color: Color(0xffC5C6C7),
                              strokeWidth: 2.w,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/Path 199@2x.png",
                                          color: Color(0xff667080)
                                              .withOpacity(0.4),
                                          scale: 3.5,
                                        ),
                                        SizedBox(
                                          height: 17.h,
                                        ),
                                        Text(
                                          "Add Photos",
                                          style: GoogleFonts.abel(
                                            color: Color(0xff667080)
                                                .withOpacity(0.4),
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                  ),
                  30.verticalSpace,

                  TextFormField(
                    cursorColor: Colors.grey,

                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(fontSize: 14.sp),
                      hintText: "Box 1",
                      labelText: "Box Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(color: Color(0xffEA8806), fontSize: 14.sp),
                    ),

                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Box name';
                      }
                      return null;
                    },

                    controller: usernameController,

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
                  ),
                  // namess("Box Name", "Box 1"),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 190.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffF1F1F5).withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              color: Color(0xffF1F1F5),
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(color: Color(0xffF5A234))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Color(0xffF5A234),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final current =
                              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
                          if (imageFile != null &&
                              _formKey.currentState!.validate()) {
                            var data = {
                              "thumbnail": imageFile,
                              "box_name": usernameController.text,
                              "user_date": current
                            };
                            log(current);
                            print(data.toString());
                            await ApiServices()
                                .createBox(context, data, imageFile);
                          } else {
                            if (imageFile == null) {
                              Get.snackbar(
                                  'Alert!',
                                  // imageFile != null
                                  //     ? "Complete Your Box"
                                  // :
                                  "Upload Image",
                                  animationDuration: Duration(seconds: 2),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.white);
                            }
                          }
                        },

                        // final bottomcontroller = Get.put(BottomController());
                        // bottomcontroller.navBarChange(1);
                        // Get.to(() => MainScreen());

                        child: Container(
                          width: 190.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffF09722).withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 1), // changes position of shadow
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
                                  "Add",
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
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  namess(
    txt,
    txt1,
  ) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              txt,
              style: TextStyle(color: Color(0xffEA8806), fontSize: 14.sp),
            ),
            12.verticalSpace,
            Text(
              txt1,
              style: TextStyle(color: Color(0xff2C2C2C), fontSize: 19.sp),
            ),
            13.verticalSpace,
            Container(
              width: 388.w,
              height: 1,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }
}
