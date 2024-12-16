import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/services/http_helper.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import '../../Controller/UserController.dart';
import 'FilterResult(3 Boxes).dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var grade;
  final BoxidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getcategory();
  }

  getcategory() async {
    await ApiServices()
        .getAllCategories()
        .then((value) => value == true || mounted ? setState(() {}) : null);
  }

  String categoryName = "";
  String? categoryValue;

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController itemName = TextEditingController();
  TextEditingController _startDate = TextEditingController();

  TextEditingController _endDate = TextEditingController();

  final itemNameList = [];

  final GlobalKey<FormState> dropDownKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log("rebuilded");
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Filter",
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
        actions: [
          GestureDetector(
            onTap: () {
              // Get.offAndToNamed("/FilterScreen");
              log("reset");
              itemName.clear();
              categoryName = "";
              itemNameList.clear();
              categoryValue = null;

              startDate = null;
              _startDate.clear();
              endDate = null;
              _endDate.clear();
              setState(() {});
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 14, right: 10),
                child: Text(
                  "Clear All",
                  style: TextStyle(color: Color(0xffEA8806), fontSize: 19.sp),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                31.verticalSpace,
                Row(
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(
                        color: Color(0xff2C2C2C),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                5.verticalSpace,
                Container(
                  width: 390.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffEA8806)),
                    borderRadius: BorderRadius.circular(25.r),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      itemNameList.add(value);
                      setState(() {});
                    },
                    controller: itemName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, top: 3),
                      // labelText: "Type a message",
                      hintText: "Search here",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xffA7B1BF),
                        fontFamily: "Inter, Regular",
                      ),
                      suffixIcon: Container(
                        width: 50.w,
                        height: 30.h,
                        child: Row(
                          children: [
                            7.horizontalSpace,
                            Container(
                              width: 40.w,
                              height: 40.h,
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   color: Color(0xff00DBFA),
                              // ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/Group 450@2x.png",
                                  scale: 3,
                                  color: Color(0xffA7B1BF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // 30.verticalSpace,
                cross(),
                // 30.verticalSpace,
                Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        color: Color(0xff2C2C2C),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                5.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: 390.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffEA8806)),
                    borderRadius: BorderRadius.circular(25.r),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'Select category',
                        selectionColor: Colors.black,
                      ),
                      items: UserController.catmodel.data == null
                          ? []
                          : UserController.catmodel.data!.map(
                              (category) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    // print("category_name" + category.categoryName.toString());
                                    // print("id" + category.id.toString());
                                    grade = category.id;

                                    // print("skdjfksjdf" + grade.toString());
                                  },
                                  value: category.categoryName.toString(),
                                  child: Text(
                                    category.categoryName.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                      onChanged: (newValue) async {
                        categoryName = newValue.toString();
                        categoryValue = categoryName;
                        setState(() {});
                      },
                      value: categoryValue,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: 390.w,
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Color(0xffEA8806)),
                //     borderRadius: BorderRadius.circular(25.r),
                //     color: Colors.white,
                //   ),
                //   child: DropdownButtonFormField(

                //     value:  categoryValue,
                //     onTap: () async {
                //       if (UserController.catmodel.data == null) {
                //         getcategory();
                //         log("counter ");
                //       }
                //     },
                //     dropdownColor: Color(0xffe9f3ff),
                //     // alignment: Alignment.topCenter,
                //     borderRadius: BorderRadius.circular(15.r),
                //     // isDense: true,
                //     icon: Icon(
                //       Icons.arrow_drop_down,
                //     ),
                //     items: UserController.catmodel.data == null
                //         ? []
                //         : UserController.catmodel.data!.map(
                //             (category) {
                //               return DropdownMenuItem(
                //                 onTap: () {
                //                   // print("category_name" + category.categoryName.toString());
                //                   // print("id" + category.id.toString());
                //                   grade = category.id;

                //                   // print("skdjfksjdf" + grade.toString());
                //                 },
                //                 value: category.categoryName.toString(),
                //                 child: Text(
                //                   category.categoryName.toString(),
                //                   style: TextStyle(
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //               );
                //             },
                //           ).toList(),
                //     onChanged: (newValue) async {
                //       categoryName = newValue.toString();
                //       categoryValue = categoryName;
                //     },
                //     // validator: (value) => value == null ? 'field required' : null,
                //     validator: (text) {
                //       if (text == null) {
                //         return 'Select category';
                //       }
                //       return null;
                //     },

                //     decoration: InputDecoration(

                //       floatingLabelBehavior: FloatingLabelBehavior.never,
                //       contentPadding: EdgeInsets.only(left: 20),
                //       hintStyle: TextStyle(fontSize: 19.sp),
                //       hintText: categoryName.isNotEmpty ? categoryName : 'Select Category',
                //       labelStyle: TextStyle(fontSize: 19.sp),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide.none,
                //       ),
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide.none,
                //       ),
                //       filled: false,
                //       // prefixIcon: Padding(
                //       //   padding: const EdgeInsets.all(14.0),
                //       //   child: Image.asset(
                //       //     "assets/images/Path 199@2x.png",
                //       //     width: 20,
                //       //     height: 20,
                //       //   ),
                //       // ),
                //     ),
                //   ),
                // ),

                // Container(
                //   width: 390.w,
                //   height: 50.h,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
                //   ),
                //   child: DropdownButtonFormField(
                //     hint: Padding(
                //       padding: const EdgeInsets.only(left: 20),
                //       child: Text(
                //         "Smoke",
                //         style: TextStyle(color: Colors.black),
                //       ),
                //     ),
                //     decoration: InputDecoration(
                //       // errorBorder: InputBorder.none,
                //       // focusedBorder: InputBorder.none,
                //       // enabledBorder: InputBorder.none,

                //       errorBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Color(0xff7E91B1)),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(30.0),
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Color(0xff7E91B1)),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(30.0),
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Color(0xff7E91B1)),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(30.0),
                //         ),
                //       ),
                //       contentPadding: EdgeInsets.all(10.0),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Color(0xff7E91B1)),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(30.0),
                //         ),
                //       ),
                //       filled: true,
                //       fillColor: Colors.white,
                //     ),
                //     items: ['Smoke', 'Drink'].map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       categoryName = value.toString();
                //       // Handle the value change
                //     },
                //   ),
                // ),

                30.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Date",
                        style: TextStyle(
                          color: Color(0xff2C2C2C),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " (optional)",
                        style: TextStyle(
                          color: Color(0xff2C2C2C),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ])),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            startDate = null;
                            _startDate.clear();
                            endDate = null;
                            _endDate.clear();
                          });
                        },
                        icon: Icon(
                          Icons.restart_alt_rounded,
                          size: 20,
                          color: Color(0xffEA8806),
                        ))
                  ],
                ),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 185.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: _startDate,
                        onTap: () async {
                          {
                            startDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime.now());
                            if (startDate != null) {
                              _startDate.text =
                                  DateFormat('MMM d, yyyy').format(startDate!);
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Start Date",
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 185.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: TextFormField(
                        onTap: () async {
                          {
                            endDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: startDate ?? DateTime(2022),
                                lastDate: DateTime.now());
                            if (endDate != null) {
                              _endDate.text =
                                  DateFormat('MMM d, yyyy').format(endDate!);
                            }
                          }
                        },
                        controller: _endDate,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          hintText: "End Date",
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7E91B1)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                50.verticalSpace,
                GestureDetector(
                  onTap: () async {
                    if (itemName.text.trim() != "") {
                      if (!itemNameList.contains(itemName.text.trim())) {
                        setState(() {
                          itemNameList.add(itemName.text.trim());
                        });
                      }
                    }
                    // if
                    // (itemNameList.isEmpty) {
                    //   Get.snackbar("Select Item", "Please select an item");
                    // } else
                    //  {
                    Map<String, dynamic> data = {};
                    if (categoryName != "") {
                      data = {'cat_name[]': categoryName.toString()};
                    }
                    if (startDate != null) {
                      data['start_date'] =
                          "${startDate!.year}-${startDate!.month}-${startDate!.day}";
                    }
                    if (endDate != null) {
                      print(endDate);
                      data['end_date'] =
                          "${endDate!.year}-${endDate!.month}-${endDate!.day}";
                    }
                    for (var i = 0; i < itemNameList.length; i++) {
                      data['item_name[$i]'] = itemNameList[i];
                    }

                    if (data == {}) {
                      Utils.showSnackBar(type: false, msg: 'Select value');
                    } else {
                      HttpHelper.ins.initializeDio();
                      log(data.toString());
                      final response =
                          await HttpHelper.ins.post('lov', data, context);

                      log(response.toString());
                      if (response['status'] == true) {
                        Get.snackbar("Success", response['message'],
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                        final List updatedList =
                            response['boxes'] as List? ?? [];
                        final List<Box> boxList =
                            updatedList.map((e) => Box.fromJson(e)).toList();
                        Get.to(() => FilterResultScreen(
                              boxList: boxList,
                            ));
                      } else {
                        Get.snackbar(
                            "Error",
                            response['message'] as String? ??
                                "Something went wrong",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    }

                    // }
                    // await ApiServices().filterApi(context, data);
                  },
                  child: Container(
                    width: 390.w,
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
                            "Apply Filter",
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

  cross() {
    return GridView.builder(
      padding:
          EdgeInsets.symmetric(vertical: itemNameList.length > 0 ? 30 : 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: itemNameList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xff7E91B1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                itemNameList[index],
                style: TextStyle(color: Color(0xff2C2C2C), fontSize: 14.sp),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    itemNameList.removeAt(index);
                  });
                },
                child: Image.asset(
                  "assets/images/Icon ionic-ios-close@2x.png",
                  scale: 1.9,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
