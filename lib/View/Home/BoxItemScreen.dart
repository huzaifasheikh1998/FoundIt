import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Model/box_item.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:foundit/View/Alert/qr_generated_alert.dart';
import 'package:foundit/View/Home/AddNewItem.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/services/api_services.dart';
import 'package:get/get.dart';

class BoxItemScreen extends StatefulWidget {
  const BoxItemScreen({super.key, required this.box});
  final Box box;

  @override
  State<BoxItemScreen> createState() => _BoxItemScreenState();
}

class _BoxItemScreenState extends State<BoxItemScreen> {
  String BoxQr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          // "Box 1",
          "${widget.box.boxName}",
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
      body: FutureBuilder(
          future:
              ApiServices().callGetBoxItems(context, widget.box.id.toString()),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              // if (snapshot.data == true) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  20.verticalSpace,
                  Container(
                      height: 0.6.sh,
                      child: Obx(
                        () => items.value.length == 0
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 0.2.sh),
                                    child: Image.asset(
                                      "assets/images/folder.png",
                                      scale: 5,
                                    ),
                                  ),
                                  Text("Currently no items in the box")
                                ],
                              )
                            // Center(
                            //     child: Text("Currently no items in the box"))

                            : ListView.separated(
                                itemCount: items.value.length,
                                itemBuilder: ((context, index) {
                                  return Box(items[index], context);
                                }),
                                separatorBuilder: (context, index) =>
                                    15.h.verticalSpace,
                              ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.toNamed("/AddNewItemScreen");
                          Get.to(() => AddNewItemScreen(box: widget.box));
                        },
                        child: Container(
                          width: 51.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xffEA8806),
                                Color(0xffEA8806),
                              ],
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/Icon awesome-plus@2x.png",
                            scale: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  50.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      if (BoxQr == '') {
                        ApiServices()
                            .generateBoxQrCode(
                                widget.box.id.toString().trim(), context)
                            .then((value) {
                          if (value != "") {
                            BoxQr = value.toString().trim();
                            log(BoxQr.toString(), name: "Boxqr");
                            qrGeneratedAlert(BoxQr,
                                widget.box.id.toString().trim(), context);
                          }
                        });
                      } else {
                        log(BoxQr.toString(), name: "Boxqr");
                        qrGeneratedAlert(
                            BoxQr, widget.box.id.toString().trim(), context);
                      }
                      // Function1();
                    },
                    child: Container(
                      width: 389.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(01),
                            spreadRadius: 1,
                            blurRadius: 2,
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
                              "Create QR Code",
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
              );
              // } else {
              //   return Text("Currently no items in the box");
              // }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xffEA8806),
                ),
              );
            }
          })),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          // "Box 1",
          "${widget.box.boxName}",
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
                20.verticalSpace,
                Box("Vape", "assets/images/Mask Group 16@2x.png"),
                15.verticalSpace,
                Box("Pod", "assets/images/Mask Group 15@2x.png"),
                15.verticalSpace,
                Box("Mobile", "assets/images/Mask Group 14@2x.png"),
                15.verticalSpace,
                Box("Mouse", "assets/images/Mask Group 13@2x.png"),
                15.verticalSpace,
                Box("Charger", "assets/images/Mask Group 11@2x.png"),
                15.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/AddNewItemScreen");
                      },
                      child: Container(
                        width: 51.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffEA8806),
                              Color(0xffEA8806),
                            ],
                          ),
                        ),
                        child: Image.asset(
                          "assets/images/Icon awesome-plus@2x.png",
                          scale: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                50.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Function1();
                  },
                  child: Container(
                    width: 389.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(01),
                          spreadRadius: 1,
                          blurRadius: 2,
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
                            "Create QR Code",
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
*/
  Box(
      // Txt,
      // Img,
      BoxItem _item,
      BuildContext context) {
    log(baseUrl + _item.thumbnail);
    return Container(
      width: 390.w,
      height: 91.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Container(
              width: 98.w,
              height: 78.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(baseUrl + _item.thumbnail))),
              // child: Image.network(baseUrl + Img),
            ),
            26.horizontalSpace,
            Container(
              width: 80,
              child: Text(
                _item.itemName.toString(),
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            120.horizontalSpace,
            InkWell(
              onTap: () async {
                // log(_item.id.toString());
                await ApiServices()
                    .deleteBoxItem(_item.id.toString(), context)
                    .then((value) => value ? setState(() {}) : null);
              },
              child: Container(
                width: 16.w,
                height: 21.h,
                child: Image.asset("assets/images/Icon material-delete@2x.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
