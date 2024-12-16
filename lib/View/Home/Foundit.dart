import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/Controller/ad_controller.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:foundit/Repo/notification_repo.dart';
import 'package:foundit/Utils/app_assets.dart';
import 'package:foundit/View/Home/NotificationScreen.dart';
import 'package:foundit/View/Home/SubscriptionPackages.dart';
import 'package:foundit/View/Home/scan_qr_screen.dart';
import 'package:foundit/View/subscriptions_new.dart';
import 'package:foundit/ViewModel/notification_view_model.dart';
import 'package:foundit/main.dart';
import 'package:foundit/services/add_mob_helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/api_services.dart';

class FounditScreen extends StatefulWidget {
  const FounditScreen({super.key});

  @override
  State<FounditScreen> createState() => _FounditScreenState();
}

class _FounditScreenState extends State<FounditScreen> {
//   Future<void> scanQR() async {
//     String barcodeScanRes;
// // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

// // If the widget was removed from the tree while the asynchronous platform
// // message was in flight, we want to discard the reply rather than calling
// // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       var _scanBarcode = barcodeScanRes;
//     });
//   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdmobHelper().loadBannerAd();
    // AdmobHelper.getBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 150,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Foundit",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 17.w),
            child: GestureDetector(
                onTap: () {
                  Get.to(() => NotificationScreen(viewModel: getIt()));
                },
                child: SvgPicture.asset("assets/images/notification.svg")),
          )
        ],
        // tra: Padding(
        //   padding: EdgeInsets.only(left: 20.w, top: 20),
        //   child: Container(
        //       width: 150.w,
        //       height: 38.h,
        // child: Text(
        //   "Foundit",
        //   style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Color(0xff2C2C2C)),
        // )),
        // ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                child: Column(
                  children: [
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 355.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEA8806)),
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => Get.toNamed("/FilterScreen"),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 25, top: 3.h),
                              // labelText: "Type a message",
                              hintText: "Search here",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xffA7B1BF),
                                fontFamily: "Inter, Regular",
                              ),
                              suffixIcon: Container(
                                width: 50.w,
                                height: 30.h,
                                child: Row(
                                  children: [
                                    7.horizontalSpace,
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      // decoration: BoxDecoration(
                                      //   shape: BoxShape.circle,
                                      //   color: Color(0xff00DBFA),
                                      // ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/Group 450@2x.png",
                                          scale: 3,
                                          color: Color(0xffA7B1BF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/FilterScreen");
                          },
                          child: Container(
                            width: 44.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffFFB24B),
                                  Color(0xffEA8806),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/images/Icon material-filter-list@2x.png",
                              scale: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                    40.verticalSpace,
                    Row(
                      children: [
                        Container(
                          width: 114.w,
                          height: 114.h,
                          child: Image.asset("assets/images/Group 320@2x.png"),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Stuff",
                              style: TextStyle(
                                fontSize: 27.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "Entries Remaining",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color:
                                          Color(0xff6C6C6C).withOpacity(0.4)),
                                ),
                                18.horizontalSpace,
                                Text(
                                  "22 of 30",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color:
                                          Color(0xffEA8806).withOpacity(0.4)),
                                ),
                              ],
                            ),
                            15.verticalSpace,
                            GestureDetector(
                              onTap: () async {
                                AdmobHelper().loadBannerAd();
                                AdmobHelper.getBannerAd();

                                if (User.data.subscriptionModel.status
                                        .toLowerCase() ==
                                    "active") {
                                  await Function1().whenComplete(() {
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  });
                                } else
                                  Get.to(() => SubscriptionPackagesScreenNew());
                              },
                              child: Container(
                                width: 217.w,
                                height: 37.h,
                                decoration: BoxDecoration(
                                  color: Color(0xffEA8806),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (User.data.subscriptionModel.status
                                              .toLowerCase() ==
                                          "active")
                                        Text(
                                          "Premium",
                                          style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      else
                                        Text(
                                          "Upgrade to Premium",
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
                      ],
                    ),
                    54.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/AddNewBoxScreen");
                          },
                          child: Container(
                            width: 188.w,
                            height: 133.h,
                            child:
                                Image.asset("assets/images/Group 316@2x.png"),
                          ),
                        ),
                        Container(
                          width: 188.w,
                          height: 133.h,
                          child: Image.asset("assets/images/Group-453.png"),
                        )
                      ],
                    ),
                    14.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ScanQrScreen());
                          },
                          child: Container(
                            width: 188.w,
                            height: 133.h,
                            child:
                                Image.asset("assets/images/Group 314@2x.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final bottomcontroller =
                                Get.put(BottomController());
                            bottomcontroller.navBarChange(1);
                            Get.to(() => MainScreen());
                          },
                          child: Container(
                            width: 188.w,
                            height: 133.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                25.verticalSpace,
                                Container(
                                  width: 36.w,
                                  height: 36,
                                  child: Image.asset(
                                      "assets/images/Icon awesome-box@2x.png"),
                                ),
                                16.verticalSpace,
                                Text(
                                  "My Box",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                )
                              ],
                            ),
                            // child: Image.asset("assets/images/Group 314@2x.png"),
                          ),
                        )
                      ],
                    ),
                    14.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/MySavedQrScreen");
                          },
                          child: Container(
                            width: 188.w,
                            height: 133.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                25.verticalSpace,
                                Container(
                                  width: 36.w,
                                  height: 36,
                                  child: Image.asset(
                                      "assets/images/Icon awesome-qrcode@2x.png"),
                                ),
                                16.verticalSpace,
                                Text(
                                  "My Qr's",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                )
                              ],
                            ),
                            // child: Image.asset("assets/images/Group 314@2x.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/OrderHistoryScreen");
                          },
                          child: Container(
                            width: 188.w,
                            height: 133.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                25.verticalSpace,
                                Container(
                                  width: 36.w,
                                  height: 36,
                                  child: SvgPicture.asset(
                                    AppAsset.orderHistory,
                                  ),
                                ),
                                16.verticalSpace,
                                Text(
                                  "Order History",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                )
                              ],
                            ),
                            // child: Image.asset("assets/images/Group 314@2x.png"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          GetBuilder(
              init: AdController(),
              builder: (controller) {
                return controller.bannerAd != null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: SizedBox(
                            width: controller.bannerAd!.size.width.toDouble(),
                            height: controller.bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: controller.bannerAd!),
                          ),
                        ),
                      )
                    : SizedBox();
              })
        ],
      ),
    );
  }

  Future<void> Function1() {
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
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xffFFFFFF)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0.024.sh),
                          child: Text(
                            "Cancel Subscription",
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // 0.023.sh.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Are you sure you\nwant to cancel Subscription?",
                            style: TextStyle(
                                fontSize: 18.sp, color: Color(0xff2C2C2C)),
                          ),
                        ),
                        Container(
                          height: 0.06.sh,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    // width: 159.w,
                                    // height: 45.h,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffEA8806)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0.r),
                                        bottomLeft: Radius.circular(9.r),
                                      ),
                                      color: Color(0xffFFFFFF),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style:
                                            TextStyle(color: Color(0xffEA8806)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   color: Color(0xffDCE3EE),
                              //   height: 64.h,
                              //   width: 1.6.w,
                              // ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    // print("ABCDDD${AuthToken.toString()}");
                                    await ApiServices().cancelSubscriptionPlan(
                                        context, {'user_id': User.data.userId});
                                    await ApiServices().getSubscriptionPlan();
                                    Navigator.pop(context);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                    // Navigator.pop(context);
                                    // Get.toNamed("/LoginScreen");
                                  },
                                  child: Container(
                                    // width: 158.1.w,
                                    // height: 45.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(0.r),
                                        bottomRight: Radius.circular(9.r),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xffFBA739),
                                          Color(0xffEA8806),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
