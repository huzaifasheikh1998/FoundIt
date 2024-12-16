import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnterYouAddressScreen extends StatefulWidget {
  const EnterYouAddressScreen({super.key});

  @override
  State<EnterYouAddressScreen> createState() => _EnterYouAddressStateScreen();
}

class _EnterYouAddressStateScreen extends State<EnterYouAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Enter You Address",
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
                50.verticalSpace,
                Names("Full Name"),
                11.verticalSpace,
                TexttField(),
                11.verticalSpace,
                Names("Email"),
                11.verticalSpace,
                TexttField(),
                11.verticalSpace,
                Names("Enter Address"),
                11.verticalSpace,
                TexttField(),
                60.verticalSpace,
                Price("Price", "\$50"),
                10.verticalSpace,
                Price("Tax", "\$2.5"),
                10.verticalSpace,
                Price("Total", "\$25.50"),
                20.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/SelectPaymentMethodScreen");
                  },
                  child: Container(
                    width: 389.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(01),
                          spreadRadius: 0,
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
                            "Confirm",
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
      width: 398.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff7E91B1), width: 1.sp),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 30),
          hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

Price(
  txt,
  txt1,
) {
  return Container(
    width: 389.w,
    height: 60.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        30,
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0xff00000029).withOpacity(0.06),
          spreadRadius: 9,
          blurRadius: 9,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: TextStyle(
              color: Color(0xff667080),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            txt1,
            style: TextStyle(
              color: Color(0xffF09722),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
