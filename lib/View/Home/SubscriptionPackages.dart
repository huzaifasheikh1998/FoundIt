// import 'dart:math';

import 'dart:developer';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/services/api_services.dart';
import 'package:foundit/Model/plans.dart';
import 'package:foundit/services/payment_services.dart';
import 'package:get/get.dart';

import '../../services/Payment.dart';

class SubscriptionPackagesScreen extends StatefulWidget {
  const SubscriptionPackagesScreen({super.key});

  @override
  State<SubscriptionPackagesScreen> createState() =>
      _SubscriptionPackagesStateScreen();
}

class _SubscriptionPackagesStateScreen
    extends State<SubscriptionPackagesScreen> {
  final ApiServices api = ApiServices();
  final CustomStripePayment _stripePayment = CustomStripePayment();

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: api.getPlans(),
            builder: ((context, AsyncSnapshot<List<Plan>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffEA8806),
                  ),
                );
              } else {
                // log('Furqan 3' + snapshot.data.toString());
                final List<Plan> list = snapshot.data!;
                if (list.isNotEmpty && list.length > 0) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      104.verticalSpace,
                      CarouselSlider(
                        items: List.generate(
                          list.length,
                          (index) => Container(
                            // width: 326,
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color(0xffFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              // image: DecorationImage(
                              //   image: AssetImage("assets/images/Mask Group 14@2x.png"),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  20.verticalSpace,
                                  Container(
                                    child: Text(
                                      "${list[index].planName}",
                                      // "STARTUP",
                                      style: TextStyle(
                                        color: Color(0xffEA8806),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 13),
                                            child: RichText(
                                              text: TextSpan(
                                                text: "\$",
                                                style: TextStyle(
                                                    fontSize: 25.sp,
                                                    color: Color(0xffEA8806)),
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: "",
                                                style: TextStyle(
                                                    fontSize: 25.sp,
                                                    color: Colors.black),
                                                children: subs == 1
                                                    ? <TextSpan>[
                                                        TextSpan(
                                                            text: '24',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 70,
                                                                color: Color(
                                                                    0xff878B9E))),
                                                        // TextSpan(text: '.00', style: TextStyle(color: Colors.black, fontSize: 25.sp)),
                                                      ]
                                                    : <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                '${list[index].amount}',
                                                            // text: '199',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 70,
                                                                color: Color(
                                                                    0xff2C2C2C))),
                                                        TextSpan(
                                                            text: '',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    25.sp)),
                                                      ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Per Month",
                                    // "Per Month",
                                    style: TextStyle(
                                        color:
                                            Color(0xff667080).withOpacity(0.4),
                                        fontSize: 12.sp),
                                  ),
                                  40.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => PaymentScreen(
                                            plans: list[index],
                                          ));
                                      // Get.toNamed(
                                      //     "/SelectPaymentMethodScreen");
                                      // _stripePayment.makePayment(context,
                                      //     list[index].amount.toString());
                                    },
                                    child: Container(
                                      width: 290.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEA8806),
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Try Now",
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
                        options: CarouselOptions(
                          clipBehavior: Clip.none,

                          height: 250.0,
                          // padEnds: false,
                          enlargeCenterPage: true,
                          // autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Currently No Plans Avalaible"),
                  );
                }
              }
            })

            /*    
       ListView(
        shrinkWrap: true,
        children: [
          104.verticalSpace,
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                // width: 326,
                // height: 577.h,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/Mask Group 14@2x.png"),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Container(
                        child: Text(
                          "STARTUP",
                          style: TextStyle(
                            color: Color(0xffEA8806),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                child: RichText(
                                  text: TextSpan(
                                    text: "\$",
                                    style: TextStyle(fontSize: 25.sp, color: Color(0xffEA8806)),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "",
                                    style: TextStyle(fontSize: 25.sp, color: Colors.black),
                                    children: subs == 1
                                        ? <TextSpan>[
                                            TextSpan(
                                                text: '24', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 70, color: Color(0xff878B9E))),
                                            // TextSpan(text: '.00', style: TextStyle(color: Colors.black, fontSize: 25.sp)),
                                          ]
                                        : <TextSpan>[
                                            TextSpan(
                                                text: '199', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 70, color: Color(0xff2C2C2C))),
                                            TextSpan(text: '', style: TextStyle(color: Colors.black, fontSize: 25.sp)),
                                          ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Text(
                          "Per Month",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 12.sp),
                        ),
                      ),
                      19.verticalSpace,
                      Container(
                        width: 350,
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur adipiscing",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 10.sp),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        width: 350,
                        child: Text(
                          // textAlign: TextAlign.center,
                          "elit suscipit commodo enim tellus et nascetur at ",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 10.sp),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        width: 350,
                        child: Text(
                          textAlign: TextAlign.center,
                          "accumsan, odio habitan",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 10.sp),
                        ),
                      ),
                      40.verticalSpace,
                      Circles("accumsan,habitanaccumsan habitan"),
                      10.verticalSpace,
                      Circles("accumsan, odio habitan accumsan,"),
                      10.verticalSpace,
                      Circles("accumsan, odio habitan"),
                      10.verticalSpace,
                      Circles("accumsan, odio habitan yrgtbjf"),
                      30.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/SelectPaymentMethodScreen");
                        },
                        child: Container(
                          width: 290.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xffEA8806),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Try Now",
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

              Container(
                // width: 326,
                // height: 577.h,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/Mask Group 14@2x.png"),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Container(
                        child: Text(
                          "STARTUP",
                          style: TextStyle(
                            color: Color(0xffEA8806),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                child: RichText(
                                  text: TextSpan(
                                    text: "\$",
                                    style: TextStyle(fontSize: 25.sp, color: Color(0xffEA8806)),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "",
                                    style: TextStyle(fontSize: 25.sp, color: Colors.black),
                                    children: subs == 1
                                        ? <TextSpan>[
                                            TextSpan(
                                                text: '24', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 70, color: Color(0xff878B9E))),
                                            // TextSpan(text: '.00', style: TextStyle(color: Colors.black, fontSize: 25.sp)),
                                          ]
                                        : <TextSpan>[
                                            TextSpan(
                                                text: '200', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 70, color: Color(0xff2C2C2C))),
                                            TextSpan(text: '', style: TextStyle(color: Colors.black, fontSize: 25.sp)),
                                          ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Text(
                          "Per Month",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 12.sp),
                        ),
                      ),
                      19.verticalSpace,
                      Container(
                        width: 350,
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur adipiscing",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 10.sp),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        width: 350,
                        child: Text(
                          // textAlign: TextAlign.center,
                          "elit suscipit commodo enim tellus et nascetur at ",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 10.sp),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        width: 350,
                        child: Text(
                          textAlign: TextAlign.center,
                          "accumsan, odio habitan",
                          style: TextStyle(color: Color(0xff667080).withOpacity(0.4), fontSize: 10.sp),
                        ),
                      ),
                      40.verticalSpace,
                      Circles("accumsan,habitanaccumsan habitan"),
                      10.verticalSpace,
                      Circles("accumsan, odio habitan accumsan,"),
                      10.verticalSpace,
                      Circles("accumsan, odio habitan"),
                      10.verticalSpace,
                      Circles("accumsan, odio habitan yrgtbjf"),
                      30.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/SelectPaymentMethodScreen");
                        },
                        child: Container(
                          width: 290.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xffEA8806),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Try Now",
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

     
            ],

           
            options: CarouselOptions(
              height: 530.0,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
*/

            ));
  }

  Circles(
    txt,
  ) {
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
            ))
      ],
    );
  }
}
