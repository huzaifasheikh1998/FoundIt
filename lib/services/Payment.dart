import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/resources/components/card_widget.dart';
import 'package:foundit/services/stripe_services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/BottomController.dart';
import '../Model/plans.dart';
import '../NavBar/Navbar.dart';
import 'AddCard.dart';
import 'api_services.dart';

class PaymentScreen extends StatefulWidget {
  Plan? plans;
  final bool fromTeacherFlow;
  PaymentScreen({
    super.key,
    this.plans,
    this.fromTeacherFlow = false,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CardDetails? cardDetails;
  String cardHolderName = '';
  final StripeController stripeController = Get.put(StripeController());
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Payment",
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
        child: Column(
          children: [
            30.verticalSpace,
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    16.03.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> map = await Get.to(
                            () => AddCardScreen(),
                            transition: Transition.circularReveal,
                            duration: Duration(seconds: 2));
                        cardDetails = map['cardDetails'];
                        cardHolderName = map['cardHolderName'].toString();
                        setState(() {});
                      },
                      child: CardWidget(
                        cardHolderName: cardHolderName ?? null,
                        cardNumber: cardDetails?.number ?? null,
                        expMonth:
                            cardDetails?.expirationMonth.toString() ?? null,
                        expYear: cardDetails?.expirationYear.toString() ?? null,
                      ),
                    ),
                    48.55.verticalSpace,
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 130.w,
                              child: Text(
                                "Price",
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Color(0xff2C303E),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '\$${widget.plans?.amount ?? '0'}',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Color(0xff2C303E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        Container(
                          width: 369.w,
                          height: 1.h,
                          color: Color(0xffEEF1F4),
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // width: 130.w,
                              child: Text(
                                "Marchand Fee",
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Color(0xff2C303E),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "\$2.5",
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Color(0xff2C303E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        Container(
                          width: 369.w,
                          height: 1.h,
                          color: Color(0xffEEF1F4),
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // width: 130.w,
                              child: Text(
                                "Total",
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Color(0xff2C303E),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "\$3602.5",
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20.sp,
                                  color: Color(0xff2C303E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        130.verticalSpace,
                        GetBuilder<PaymentController>(builder: (controller) {
                          return GestureDetector(
                            onTap: () async {
                              if ((cardDetails?.number?.isNotEmpty ?? false) &&
                                  widget.plans != null) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                );
                                // controller.showLoader();
                                await stripeController
                                    .subscriptions(
                                        context: context,
                                        name: cardHolderName,
                                        email: User.data.userEmail,
                                        cardDetails:
                                            cardDetails ?? CardDetails(),
                                        plans: widget.plans!)
                                    .then((value) async {
                                  if (value != null && value) {
                                    // controller.hideLoader();
                                    await ApiServices().getSubscriptionPlan();
                                    // Navigator.pop(context);
                                    Get.offAll(() => MainScreen());
                                  }
                                }).onError((error, stackTrace) {
                                  Navigator.pop(context);

                                  Get.snackbar('Error', error.toString(),
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                });
                              } else {
                                Get.snackbar(
                                    'Required', 'Please fill Card Details.');
                              }
                            },
                            child: Container(
                              width: 290.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Color(0xffEA8806),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: controller.isLoading
                                    ? CupertinoActivityIndicator(
                                        color: Colors.white)
                                    : Text(
                                        "Pay Now",
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          color: Colors.white,
                                        ),
                                        // style: TextStyle(
                                        //   fontSize: 25.sp,
                                        //   color: Colors.white,
                                        //   fontWeight: FontWeight.bold,
                                        // ),
                                      ),
                              ),
                            ),
                          );
                        }),
                        0.verticalSpace,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Function1() {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (BuildContext context, setState) {
//             return AlertDialog(
//               // contentPadding: EdgeInsets.zero,
//               insetPadding: EdgeInsets.zero,
//               backgroundColor: Color(0xff000000B8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.r),
//               ),
// // contentPadding: EdgeInsets.all(0),
//               actionsPadding: EdgeInsets.all(0),
//               actions: [
//                 Container(
//                   width: 322.w,
//                   height: 350.h,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: Color(0xffFFFFFF),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       // mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         24.verticalSpace,
//                         Container(
//                           child: Image.asset(
//                             "assets/smile.png",
//                             // scale: 3,
//                           ),
//                         ),
//                         31.verticalSpace,
//                         Container(
//                           child: Text(
//                             "Congratulations",
//                             style: GoogleFonts.josefinSans(
//                               fontSize: 35.sp,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         10.verticalSpace,
//                         Container(
//                           child: Text(
//                             "Payment Successfully",
//                             style: GoogleFonts.josefinSans(
//                               fontSize: 22.sp,
//                               color: Color(0xff707070),
//                               // fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         28.verticalSpace,
//                         GestureDetector(
//                           onTap: () {
//                             // final bottomcontroller = Get.put(BottomController());
//                             // bottomcontroller.navBarChange(0);
//                             // Get.to(() => NavigationsBarScreen());
//                           },
//                           child: Container(
//                             width: 299.w,
//                             height: 52.h,
//                             decoration: BoxDecoration(
//                               color: Color(0xffDE7FC4),
//                               borderRadius: BorderRadius.circular(25.r),
//                               border: Border.all(
//                                 color: Color(0xffFFE74D),
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Go Back To Home",
//                                 style: GoogleFonts.ebGaramond(
//                                   fontSize: 25.sp,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           });
//         });
//   }

//   Function2() {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (BuildContext context, setState) {
//             return AlertDialog(
//               // contentPadding: EdgeInsets.zero,
//               insetPadding: EdgeInsets.zero,
//               backgroundColor: Color(0xff000000B8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.r),
//               ),
// // contentPadding: EdgeInsets.all(0),
//               actionsPadding: EdgeInsets.all(0),
//               actions: [
//                 Container(
//                   width: 322.w,
//                   height: 350.h,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: Color(0xffFFFFFF),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       // mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         24.verticalSpace,
//                         Container(
//                           child: Image.asset(
//                             "assets/smile.png",
//                             // scale: 3,
//                           ),
//                         ),
//                         31.verticalSpace,
//                         Container(
//                           child: Text(
//                             "Congratulations",
//                             style: GoogleFonts.josefinSans(
//                               fontSize: 35.sp,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         10.verticalSpace,
//                         Container(
//                           child: Text(
//                             "Payment Successfully",
//                             style: GoogleFonts.josefinSans(
//                               fontSize: 22.sp,
//                               color: Color(0xff707070),
//                               // fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         28.verticalSpace,
//                         GestureDetector(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: Container(
//                             width: 299.w,
//                             height: 52.h,
//                             decoration: BoxDecoration(
//                               color: Color(0xffDE7FC4),
//                               borderRadius: BorderRadius.circular(25.r),
//                               border: Border.all(
//                                 color: Color(0xffFFE74D),
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Go Back",
//                                 style: GoogleFonts.ebGaramond(
//                                   fontSize: 25.sp,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           });
//         });
//   }

  Function3() {
    return showDialog(
      barrierDismissible: true,
      // barrierColor: Colors.white,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xff000000B8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
              contentPadding: EdgeInsets.all(0),
              actionsPadding: EdgeInsets.all(0),
              actions: [
                Container(
                  width: 0.744.sw,
                  height: 0.246.sh,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xffFFFFFF)),
                  child: Column(children: [
                    Container(
                      child: Text(
                        "Congratulations",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Container(
                      child: Text(
                        "Payment Successfully",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Color(0xff707070),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    28.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        final bottomcontroller = Get.put(BottomController());
                        bottomcontroller.navBarChange(0);
                        Get.off(() => MainScreen());
                      },
                      child: Container(
                        width: 290.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Color(0xffEA8806),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: Text(
                            "Go Back To Home",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class PaymentController extends GetxController {
  bool isLoading = false;
  void showLoader() {
    isLoading = true;
    update();
  }

  void hideLoader() {
    isLoading = false;
    update();
  }
}
