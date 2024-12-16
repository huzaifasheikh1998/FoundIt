import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/Controller/UserController.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key, required this.box});
  final Box box;

  @override
  State<AddNewItemScreen> createState() => _AddNewItemStateScreen();
}

class _AddNewItemStateScreen extends State<AddNewItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController = TextEditingController();
  final ItemNameController = TextEditingController();
  final BoxidController = TextEditingController();
  final detailController = TextEditingController();
  final picker = ImagePicker();
  File? imageFile1;
  final catmodel = Get.put(UserController());
  void _getFromGallery() async {
    final result = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null)
      setState(() {
        imageFile1 = File(result.path);
      });
  }

  var grade;
  @override
  void initState() {
    super.initState();
    getcategory();
    BoxidController.text = widget.box.boxName.toString();
  }

  getcategory() async {
    await ApiServices()
        .getAllCategories()
        .then((value) => value == true && mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    getcategory();
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add New Item",
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
                    child: imageFile1 != null
                        ? Container(
                            width: 390.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: Colors.white,
                              image: DecorationImage(
                                image: FileImage(imageFile1!),
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
                  Container(
                    width: Get.width * 0.9,
                    child: DropdownButtonFormField(
                      onTap: () async {
                        if (UserController.catmodel.data == null) {
                          getcategory();
                          log("counter ");
                        }
                      },
                      dropdownColor: Color(0xffe9f3ff),
                      // alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.circular(15.r),
                      // isDense: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      items: UserController.catmodel.data == null
                          ? []
                          : UserController.catmodel.data!.map(
                              (category) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    print("category_name" +
                                        category.categoryName.toString());
                                    print("id" + category.id.toString());
                                    grade = category.id;
                                    print("skdjfksjdf" + grade.toString());
                                  },
                                  value: category.id.toString(),
                                  child: Text(
                                    category.categoryName.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                      onChanged: (newValue) async {},
                      // validator: (value) => value == null ? 'field required' : null,
                      validator: (text) {
                        if (text == null) {
                          return 'Select category';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 19.sp),
                        labelText: "Category",
                        labelStyle: TextStyle(
                            color: Color(0xffEA8806), fontSize: 19.sp),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: false,
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.all(14.0),
                        //   child: Image.asset(
                        //     "assets/images/Path 199@2x.png",
                        //     width: 20,
                        //     height: 20,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  // TextFormField(
                  //   cursorColor: Colors.grey,
                  //   decoration: InputDecoration(
                  //     enabledBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey),
                  //     ),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey),
                  //     ),
                  //     hintStyle: TextStyle(fontSize: 19.sp),
                  //     hintText: "Smoke",
                  //     labelText: "Category",
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     labelStyle: TextStyle(color: Color(0xffEA8806), fontSize: 19.sp),
                  //   ),
                  //   validator: (text) {
                  //     if (text == null || text.isEmpty) {
                  //       return 'Enter Box name';
                  //     }
                  //     return null;
                  //   },
                  //   controller: CategoryController,
                  // ),
                  29.verticalSpace,
                  TextFormField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(fontSize: 19.sp),
                      hintText: "Enter your item",
                      labelText: "Item Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(color: Color(0xffEA8806), fontSize: 19.sp),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Item name';
                      }
                      return null;
                    },
                    controller: ItemNameController,
                  ),
                  29.verticalSpace,
                  TextFormField(
                    cursorColor: Colors.grey,
                    // readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(fontSize: 19.sp),
                      hintText: "Box 1",
                      labelText: "Box Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(color: Color(0xffEA8806), fontSize: 19.sp),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Box name';
                      }
                      return null;
                    },
                    controller: BoxidController,
                    readOnly: true,
                  ),
                  29.verticalSpace,
                  TextFormField(
                    cursorColor: Colors.grey,
                    // readOnly: true,
                    minLines: 2,
                    maxLines: 2,
                    style: TextStyle(color: Color(0xff2C2C2C), fontSize: 14.sp),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Color.fromARGB(150, 44, 44, 44),
                          fontSize: 14.sp),
                      hintText: "Enter your item details",
                      labelText: "Details",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(color: Color(0xffEA8806), fontSize: 19.sp),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter details of item';
                      }
                      return null;
                    },
                    controller: detailController,
                    readOnly: false,
                  ),
                  29.verticalSpace,
                  // Row(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Details",
                  //           style: TextStyle(
                  //               color: Color(0xffEA8806), fontSize: 14.sp),
                  //         ),
                  //         12.verticalSpace,
                  //         Container(
                  //           width: 388.w,
                  //           height: 70.h,
                  //           child:
                  //            Text(
                  //             textAlign: TextAlign.left,
                  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem  the industry's",
                  //             style: TextStyle(
                  //                 color: Color(0xff2C2C2C), fontSize: 14.sp),
                  //           ),

                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
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
                          if (imageFile1 != null &&
                              _formKey.currentState!.validate()) {
                            var data = {
                              // "thumbnail": imageFile1,
                              "item_name": ItemNameController.text.trim(),
                              "box_id": widget.box.id.toString().trim(),
                              "category_id": grade,
                              "description":
                                  detailController.text.toString().trim(),
                              "user_date":
                                  "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                            };
                            print(data.toString());
                            await ApiServices()
                                .CallAddnewitem(context, data, imageFile1);
                          } else {
                            if (imageFile1 == null) {
                              Get.snackbar('Alert!', "Upload Image",
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
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.back();
                      //   },
                      //   child: Container(
                      //     width: 190.w,
                      //     height: 50.h,
                      //     decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Color(0xffF09722).withOpacity(0.4),
                      //           spreadRadius: 5,
                      //           blurRadius: 6,
                      //           offset: Offset(0, 1), // changes position of shadow
                      //         ),
                      //       ],
                      //       gradient: LinearGradient(
                      //         begin: Alignment.bottomRight,
                      //         end: Alignment.bottomLeft,
                      //         colors: [
                      //           Color(0xffF5A336),
                      //           Color(0xffF09722),
                      //         ],
                      //       ),
                      //       borderRadius: BorderRadius.circular(30.r),
                      //     ),
                      //     child: Center(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             "Add",
                      //             style: TextStyle(
                      //               color: Color(0xffFFFFFF),
                      //               fontSize: 16.sp,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
            ),
          ],
        )
      ],
    );
  }
}
