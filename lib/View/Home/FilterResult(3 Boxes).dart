import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Model/get_boxes_model.dart';
import '../../resources/components/Global.dart';
import 'BoxItemScreen.dart';

class FilterResultScreen extends StatefulWidget {
  final List<Box> boxList;
  const FilterResultScreen({super.key, required this.boxList});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text(
        //   "Filter",
        //   style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Color(0xff2C2C2C)),
        // ),
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
        // actions: [
        //   Container(
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 14, right: 10),
        //       child: Text(
        //         "Clear All",
        //         style: TextStyle(color: Color(0xffEA8806), fontSize: 19.sp),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    Text(
                      "Filter Result (${widget.boxList.length > 0 ? widget.boxList.length : 0} ${widget.boxList.length <= 1 ? 'Box' : 'Boxes'})",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height,
                  child: ListView.builder(
                    itemCount: widget.boxList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => BoxItemScreen(
                                box: widget.boxList[index],
                              ));
                          // Get.toNamed("/Box1Screen");
                        },
                        child: Container(
                          width: 390.w,
                          height: 91.h,
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 62.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),

                                          // border: Border.all(
                                          // color: Colors.red,
                                          // ),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                baseUrl +
                                                    widget.boxList[index]
                                                        .thumbnail
                                                        .toString(),
                                              ))),
                                      // child: Image.network(
                                      //   baseUrl +
                                      //       UserController
                                      //           .user.data![index].thumbnail
                                      //           .toString(),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    26.horizontalSpace,
                                    Text(
                                      widget.boxList[index].boxName.toString(),
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Box(
  //   Txt,
  // ) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.toNamed("/BoxfilterScreen");
  //     },
  //     child: Container(
  //       width: 390.w,
  //       height: 91.h,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(50.r),
  //         color: Colors.white,
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 15.w),
  //         child: Row(
  //           children: [
  //             Container(
  //               width: 80.w,
  //               height: 62.h,
  //               child: Image.asset("assets/images/Group 391@2x.png"),
  //             ),
  //             26.horizontalSpace,
  //             Container(
  //               child: Text(
  //                 Txt,
  //                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
