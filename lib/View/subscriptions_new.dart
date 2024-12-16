// import 'dart:math';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Controller/subscription_controller.dart';
import 'package:foundit/View/Home/PrivacyPolicy.dart';
import 'package:foundit/View/Home/Terms&Condiciton.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/Model/plans.dart';
import 'package:foundit/services/payment_services.dart';
import 'package:foundit/services/revenue_cat_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../services/Payment.dart';

class SubscriptionPackagesScreenNew extends StatefulWidget {
  const SubscriptionPackagesScreenNew({super.key});

  @override
  State<SubscriptionPackagesScreenNew> createState() =>
      _SubscriptionPackagesStateScreen();
}

class _SubscriptionPackagesStateScreen
    extends State<SubscriptionPackagesScreenNew> {
  final subscriptionController = Get.put(SubscriptionController());

  final ApiServices api = ApiServices();
  final CustomStripePayment _stripePayment = CustomStripePayment();
  final List<Plann> plans = [
    Plann(
      planName: "Monthly Plan",
      amount: "9.99",
      features: [
        "Unlimited QR Code Generation",
        "Priority Printing & Delivery",
        "Advanced Order Tracking",
        "Enhanced Security",
        "Exclusive Support"
      ],
    ),
    Plann(
      planName: "Yearly Plan",
      amount: "99.99",
      features: [
        "Unlimited QR Code Generation",
        "Priority Printing & Delivery",
        "Advanced Order Tracking",
        "Enhanced Security",
        "Exclusive Support"
      ],
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // RevenueCatApi.getCurrentOfferings();
  }

  String dateAfter30Days = DateFormat('MMMM dd, yyyy')
      .format(DateTime.now().add(const Duration(days: 30)));
  String dateAfter365Day = DateFormat('MMMM dd, yyyy')
      .format(DateTime.now().add(const Duration(days: 365)));

  @override
  Widget build(BuildContext context) {
    RevenueCatApi.getActiveEntitlements();
    // log("///dataaaaaaa//////////---" +
    //     subscriptionController
    //         .yourOfferings.value.all.values.first.availablePackages
    //         .toString());
    // log("///dataaaaaaa//////////---" +
    //     subscriptionController
    //         .yourOfferings.value.all.values.first.availablePackages
    //         .toString());
    var subs;
    var imageSliders;
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Subscription Packages",
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
      body: Obx(() {
        return subscriptionController.isLoading.value
            ? Center(child: CircularProgressIndicator()).paddingSymmetric(
                vertical: 0.3.sw,
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  70.verticalSpace,
                  CarouselSlider(
                    items: List.generate(
                      subscriptionController.yourOfferings.value.all.values
                          .first.availablePackages.length,
                      (index) => Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0xffFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                subscriptionController
                                    .yourOfferings
                                    .value
                                    .all
                                    .values
                                    .first
                                    .availablePackages[index]
                                    .storeProduct
                                    .title
                                    .replaceAll(
                                        "(com.myfounditapp.app (unreviewed))",
                                        ""),
                                style: TextStyle(
                                  color: Color(0xffEA8806),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "",
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            color: Color(0xffEA8806)),
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: TextStyle(
                                          fontSize: 25.sp, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: subscriptionController
                                              .yourOfferings
                                              .value
                                              .all
                                              .values
                                              .first
                                              .availablePackages[index]
                                              .storeProduct
                                              .priceString
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 40.sp,
                                            color: Color(0xff2C2C2C),
                                          ),
                                        ),
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                index == 0 ? "Per Month" : "Per Year",
                                style: TextStyle(
                                    color: Color(0xff667080).withOpacity(0.4),
                                    fontSize: 12.sp),
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: plans[index]
                                    .features
                                    .map((feature) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                ".",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Expanded(
                                                child: Text(
                                                  feature,
                                                  style: TextStyle(
                                                    color: Color(0xff2C2C2C),
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                              Spacer(),
                              Text(
                                "Expiration:",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              1.h.verticalSpace,
                              Text(
                                index == 0 ? dateAfter30Days : dateAfter365Day,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              5.h.verticalSpace,
                              GestureDetector(
                                onTap: () {
                                  subscriptionController
                                                  .subscriptionIndex.value !=
                                              0 &&
                                          subscriptionController
                                                      .subscriptionIndex.value -
                                                  1 ==
                                              index
                                      ? null
                                      : RevenueCatApi.buySubscription(
                                          subscriptionController
                                              .yourOfferings
                                              .value
                                              .all
                                              .values
                                              .first
                                              .availablePackages[index]);
                                },
                                child: Container(
                                  width: 290.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: subscriptionController
                                                    .subscriptionIndex.value !=
                                                0 &&
                                            subscriptionController
                                                        .subscriptionIndex
                                                        .value -
                                                    1 ==
                                                index
                                        ? Colors.grey
                                        : Color(0xffEA8806),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      subscriptionController.subscriptionIndex
                                                      .value !=
                                                  0 &&
                                              subscriptionController
                                                          .subscriptionIndex
                                                          .value -
                                                      1 ==
                                                  index
                                          ? "Subscribed"
                                          : "Try Now",
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              10.h.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      clipBehavior: Clip.none,
                      height: 400.0,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                  30.h.verticalSpace,
                  SizedBox(
                    width: 0.6.sw,
                    child: Text(
                      Platform.isAndroid
                          ? "NOTE:\nFOUNDit is a subscription-based app that auto-renews 24 hours before period end, charging your Google Play Store account then. It unlocks premium features like QR code generation, priority printing, and enhanced security. Manage or cancel in Google Play Store Account Settings, with terms subject to change - contact support for queries.\nThank you for choosing FOUNDit to streamline and enhance your storage management!"
                          : "NOTE:\nFOUNDit is a subscription-based app that auto-renews 24 hours before period end, charging your Apple App Store account then. It unlocks premium features like QR code generation, priority printing, and enhanced security. Manage or cancel in Apple App Store Account Settings, with terms subject to change - contact support for queries.\nThank you for choosing FOUNDit to streamline and enhance your storage management!",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ).paddingSymmetric(horizontal: 0.07.sw),
                  ),
                  20.h.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Click here to see ',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Terms of Service (EULA)',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                      'https://breakingboundariestx.com/terms-and-conditions');

                                  try {
                                    Get.to(() => TermsAndCondicitonScreen());

                                    // _controller.launchUrls(url);
                                  } catch (e) {
                                    Get.snackbar('Launch Failed',
                                        'Could not launch url at the moment, please come back later.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 5),
                                        colorText: Colors.black);
                                  }
                                },
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const TextSpan(
                            text: ' and ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                              text: 'Privacy Policy',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                      'https://breakingboundariestx.com/privacy-policy');
                                  try {
                                    Get.to(() => PrivacyPolicyScreen());
                                    // _controller.launchUrls(url);
                                  } catch (e) {
                                    Get.snackbar('Launch Failed',
                                        'Could not launch url at the moment, please come back later.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 5),
                                        colorText: Colors.black);
                                  }
                                },
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const TextSpan(
                            text: '.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 0.05.sw),
                  20.h.verticalSpace,
                ],
              );
      }),
    );
  }

  Circles(txt) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFFB24B),
                Color(0xffEA8806),
              ],
            ),
          ),
        ),
        10.horizontalSpace,
        Container(
          width: 240.w,
          height: 16,
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 10.sp,
              color: Color(0xff707070),
            ),
          ),
        ),
      ],
    );
  }
}

class Plann {
  final String planName;
  final String amount;
  final List<String> features;

  Plann({required this.planName, required this.amount, required this.features});
}
