import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:foundit/View/Home/scan_qr_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<void> scanQR() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Search",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            final bottomcontroller = Get.put(BottomController());
            bottomcontroller.navBarChange(0);
            Get.to(() => MainScreen());
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
                Container(
                  width: 390.w,
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
                      contentPadding: EdgeInsets.only(left: 25, top: 6),
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
                20.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.to(() => ScanQrScreen());
                  },
                  child: Container(
                    width: 390.w,
                    height: 347.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        50.verticalSpace,
                        Container(
                          width: 83.w,
                          height: 67.h,
                          child: Image.asset(
                              "assets/images/Icon feather-inbox@2x.png"),
                        ),
                        30.verticalSpace,
                        Container(
                          width: 250.w,
                          height: 60.h,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Enter at least 2 letters keywords to search.",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        11.verticalSpace,
                        Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        11.verticalSpace,
                        Container(
                          width: 290.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(01),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(
                                    0, 1), // changes position of shadow
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
                                  "Scan Box Qr",
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
                      ],
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
}
