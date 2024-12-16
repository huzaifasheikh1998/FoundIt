// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class AddCard extends StatefulWidget {
//   const AddCard({super.key});

//   @override
//   State<AddCard> createState() => _AddCardStateScreen();
// }

// class _AddCardStateScreen extends State<AddCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF1F2F6),
//       appBar: AppBar(
//         leadingWidth: 70,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Add Card",
//           style: TextStyle(
//               fontSize: 22.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff2C2C2C)),
//         ),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Padding(
//             padding: EdgeInsets.only(left: 20.w),
//             child: Container(
//               width: 56.w,
//               height: 38.h,
//               child: Image.asset("assets/images/Group 331@2x.png"),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               children: [
//                 60.verticalSpace,
//                 Row(
//                   children: [
//                     Text(
//                       "Select Card",
//                       style: TextStyle(
//                         color: Color(0xff2C2C2C),
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 15.verticalSpace,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 120.w,
//                       height: 75.h,
//                       decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.orange.withOpacity(0.06),
//                               spreadRadius: 3,
//                               blurRadius: 2,
//                               offset:
//                                   Offset(0, 1), // changes position of shadow
//                             ),
//                           ],
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(
//                             10.r,
//                           )),
//                       child: Image.asset(
//                         "assets/images/Group 93@2x.png",
//                         scale: 2,
//                       ),
//                     ),
//                     Container(
//                       width: 120.w,
//                       height: 75.h,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0.1),
//                           ),
//                           // boxShadow: [
//                           //   BoxShadow(
//                           //     color: Colors.orange.withOpacity(0.06),
//                           //     spreadRadius: 3,
//                           //     blurRadius: 2,
//                           //     offset: Offset(0, 1), // changes position of shadow
//                           //   ),
//                           // ],
//                           // color: Colors.white,
//                           borderRadius: BorderRadius.circular(
//                             10.r,
//                           )),
//                       child: Image.asset(
//                         "assets/images/580b57fcd9996e24bc43c530@2x.png",
//                         scale: 2,
//                       ),
//                     ),
//                     Container(
//                       width: 120.w,
//                       height: 75.h,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0.1),
//                           ),
//                           // boxShadow: [
//                           //   BoxShadow(
//                           //     color: Colors.orange.withOpacity(0.06),
//                           //     spreadRadius: 3,
//                           //     blurRadius: 2,
//                           //     offset: Offset(0, 1), // changes position of shadow
//                           //   ),
//                           // ],
//                           // color: Colors.white,
//                           borderRadius: BorderRadius.circular(
//                             10.r,
//                           )),
//                       child: Image.asset(
//                         "assets/images/Group 95@2x.png",
//                         scale: 2,
//                       ),
//                     )
//                   ],
//                 ),
//                 20.verticalSpace,
//                 Names("Card Holder"),
//                 6.verticalSpace,
//                 TexttField(),
//                 20.verticalSpace,
//                 Names("Card Number"),
//                 6.verticalSpace,
//                 TexttField(),
//                 20.verticalSpace,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Names("Expiry Date"),
//                         6.verticalSpace,
//                         TexttFields(),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Names("CVV"),
//                         6.verticalSpace,
//                         TexttFields(),
//                       ],
//                     )
//                   ],
//                 ),
//                 30.verticalSpace,
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                     // Get.toNamed("/Sel
//                     // ectPaymentMethodScreen");
//                   },
//                   child: Container(
//                     width: 389.w,
//                     height: 56.h,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.orange.withOpacity(0.3),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 1), // changes position of shadow
//                         ),
//                       ],
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomRight,
//                         end: Alignment.bottomLeft,
//                         colors: [
//                           Color(0xffF5A336),
//                           Color(0xffF09722),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(30.r),
//                     ),
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Add Now",
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Names(
//     txt,
//   ) {
//     return Row(
//       children: [
//         Text(
//           txt,
//           style: TextStyle(
//             color: Color(0xff2C2C2C),
//             fontSize: 14.sp,
//           ),
//         )
//       ],
//     );
//   }

//   TexttField() {
//     return Container(
//       width: 388.w,
//       height: 50.h,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Color(0xff7E91B1), width: 1.sp),
//         borderRadius: BorderRadius.circular(30.r),
//       ),
//       child: TextFormField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(left: 30),
//           hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }

//   TexttFields() {
//     return Container(
//       width: 185.w,
//       height: 50.h,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Color(0xff7E91B1), width: 1.sp),
//         borderRadius: BorderRadius.circular(30.r),
//       ),
//       child: TextFormField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(left: 30),
//           hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
