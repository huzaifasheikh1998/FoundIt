import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RateThisAppScreen extends StatefulWidget {
  const RateThisAppScreen({super.key});

  @override
  State<RateThisAppScreen> createState() => _RateThisAppStateScreen();
}

class _RateThisAppStateScreen extends State<RateThisAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Rate This App",
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
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              children: [
                215.verticalSpace,
                Container(
                  child: Image.asset(
                    "assets/images/Group 430@2x.png",
                    scale: 2,
                    color: Color(0xffEA8806),
                  ),
                ),
                29.verticalSpace,
                Container(
                  width: 350.w,
                  height: 38.h,
                  child: Text(
                    "Your opinion matters to us!",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                10.verticalSpace,
                Container(
                  width: 350.w,
                  height: 100.h,
                  child: Text(
                    textAlign: TextAlign.center,
                    "We wotk super hard to make glose better for you, and whould love to know how whould you rate our app",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff707070),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                0.verticalSpace,
                RatingBar.builder(
                  glowColor: Color(0xffEA8806),
                  itemSize: 40,
                  unratedColor: Colors.grey.withOpacity(0.5),
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star_purple500_outlined,
                    color: Color(0xffEA8806),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                40.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 180.w,
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
                            "Submit",
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
                30.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.back();
                    //  Get.toNamed("/PreLoginScreen");
                  },
                  child: Text(
                    "No Thanks",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
