import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BoxfilterScreen extends StatefulWidget {
  const BoxfilterScreen({super.key});

  @override
  State<BoxfilterScreen> createState() => _BoxfilterScreenState();
}

class _BoxfilterScreenState extends State<BoxfilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Box 1",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Box(
    Txt,
    Img,
  ) {
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
              child: Image.asset(
                Img,
              ),
            ),
            26.horizontalSpace,
            Container(
              width: 80,
              child: Text(
                Txt,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            120.horizontalSpace,
            Container(
              width: 16.w,
              height: 21.h,
              child: Image.asset("assets/images/Icon material-delete@2x.png"),
            )
          ],
        ),
      ),
    );
  }
}
