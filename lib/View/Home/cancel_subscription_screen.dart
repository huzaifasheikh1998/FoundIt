// // import 'dart:math';

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foundit/models/user_model.dart';
// import 'package:foundit/services/api_services.dart';
// import 'package:foundit/models/plans.dart';
// import 'package:foundit/services/payment_services.dart';
// import 'package:get/get.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// import '../services/Payment.dart';

// class CancelSubscriptionScreen extends StatefulWidget {
//   const CancelSubscriptionScreen({super.key});

//   @override
//   State<CancelSubscriptionScreen> createState() =>
//       _SubscriptionPackagesStateScreen();
// }

// class _SubscriptionPackagesStateScreen extends State<CancelSubscriptionScreen> {
//   final ApiServices api = ApiServices();
//   final CustomStripePayment _stripePayment = CustomStripePayment();

//   @override
//   Widget build(BuildContext context) {
//     var subs;
//     var imageSliders;
//     return Scaffold(
//         backgroundColor: Color(0xffF1F2F6),
//         appBar: AppBar(
//           leadingWidth: 70,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: Text(
//             "Current Package",
//             style: TextStyle(
//                 fontSize: 22.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff2C2C2C)),
//           ),
//           centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Padding(
//               padding: EdgeInsets.only(left: 20.w),
//               child: Container(
//                 width: 56.w,
//                 height: 38.h,
//                 child: Image.asset("assets/images/Group 331@2x.png"),
//               ),
//             ),
//           ),
//         ),
//         body: FutureBuilder(
//             future: api.getSubscriptionPlan(),
//             builder: ((context, AsyncSnapshot<SubscriptionModel?> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: Color(0xffEA8806),
//                   ),
//                 );
//               } else {
//                 // log('Furqan 3' + snapshot.data.toString());

//                 if (snapshot.data != null) {
//                   final SubscriptionModel sub = snapshot.data!;
//                   return Container(
//                     // width: 326,
//                     // height: 577.h,
//                     margin: EdgeInsets.all(6.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       color: Color(0xffFFFFFF),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                       // image: DecorationImage(
//                       //   image: AssetImage("assets/images/Mask Group 14@2x.png"),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 25.w),
//                       child: Column(
//                         children: [
//                           20.verticalSpace,
//                           Container(
//                             child: Text(
//                               "${sub.status}",
//                               // "STARTUP",
//                               style: TextStyle(
//                                 color: Color(0xffEA8806),
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 60),
//                             child: Text(
//                               "Per Month",
//                               // "Per Month",
//                               style: TextStyle(
//                                   color: Color(0xff667080).withOpacity(0.4),
//                                   fontSize: 12.sp),
//                             ),
//                           ),
//                           40.verticalSpace,
//                           Circles("accumsan,habitanaccumsan habitan"),
//                           10.verticalSpace,
//                           Circles("accumsan, odio habitan accumsan,"),
//                           10.verticalSpace,
//                           Circles("accumsan, odio habitan"),
//                           10.verticalSpace,
//                           Circles("accumsan, odio habitan yrgtbjf"),
//                           30.verticalSpace,
//                           GestureDetector(
//                             onTap: () {
//                               // Get.to(() => PaymentScreen(
//                               //       plans: list[index],
//                               //     ));
//                               // Get.toNamed(
//                               //     "/SelectPaymentMethodScreen");
//                               // _stripePayment.makePayment(context,
//                               //     list[index].amount.toString());
//                             },
//                             child: Container(
//                               width: 290.w,
//                               height: 50.h,
//                               decoration: BoxDecoration(
//                                 color: Color(0xffEA8806),
//                                 borderRadius: BorderRadius.circular(30.r),
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Try Now",
//                                       style: TextStyle(
//                                         color: Color(0xffFFFFFF),
//                                         fontSize: 16.sp,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: Text("Currently No Plans Avalaible"),
//                   );
//                 }
//               }
//             })));
//   }

//   Circles(
//     txt,
//   ) {
//     return Row(
//       children: [
//         Container(
//           width: 10.w,
//           height: 10.h,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xffFFB24B),
//                 Color(0xffEA8806),
//               ],
//             ),
//           ),
//         ),
//         10.horizontalSpace,
//         Container(
//             width: 240.w,
//             height: 16,
//             child: Text(
//               txt,
//               style: TextStyle(
//                 fontSize: 10.sp,
//                 color: Color(0xff707070),
//               ),
//             ))
//       ],
//     );
//   }
// }
