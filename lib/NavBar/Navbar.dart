import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/View/Home/Foundit.dart';
import 'package:foundit/View/Home/Home.dart';
import 'package:foundit/View/Home/Search.dart';
import 'package:foundit/View/Home/Settings.dart';
import 'package:foundit/services/add_mob_helper.dart';
import 'package:foundit/services/revenue_cat_services.dart';
import 'package:get/get.dart';

import '../Controller/BottomController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottomcontroller = Get.put(BottomController());
  int pageIndex = 0;



  final pages = [
    FounditScreen(),
    HomeScreen(),
    // Container(),
    SearchScreen(),
    SettingsScreen(),
  ];
  void _onItemTapped(int index) {
    bottomcontroller.navBarChange(index);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RevenueCatApi.getCurrentOfferings();
    RevenueCatApi.getActiveEntitlements();

    // AdmobHelper().createInterad();
    AdmobHelper().createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration:
      //     BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      width: double.infinity,
      child: Scaffold(
        extendBody: true,
        // backgroundColor: Colors.transparent,
        backgroundColor: Color.fromARGB(239, 218, 255, 231),
        body: GetBuilder<BottomController>(
          builder: (_) => pages[bottomcontroller.navigationBarIndexValue],
        ),
        bottomNavigationBar: GetBuilder<BottomController>(
          builder: (_) => buildMyNavBar(context),
        ),
        // floatingActionButton: GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       _onItemTapped(2);
        //     });

        //     // Get.to(() => CamScreen());
        //   },
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 10),
        //     child: Container(
        //         height: 80.h,
        //         width: 80.w,
        //         decoration: BoxDecoration(
        //           // border: Border.all(color: Colors.white),
        //           shape: BoxShape.circle,
        //         ),
        //         child: Container(
        //             // child: Image.asset(
        //             //   "assets/images/Group 1382.png",
        //             //   scale: 3.5,
        //             // ),
        //             )),
        //   ),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  buildMyNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          // width: 388.w,
          height: 80.h,

          // width: double.infinity,
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 2,
            //     blurRadius: 50,
            //     offset: Offset(0, -8), // changes position of shadow
            //   ),
            // ],
            borderRadius: BorderRadius.circular(50
                // topLeft: Radius.circular(70),
                // topRight: Radius.circular(70),
                ),
            color: Color(0xffEA8806),
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Color(0xff1CC8FB),
            //     Color(0xff004DF2),
            //   ],
            // ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _onItemTapped(0);
                    });

                    // Get.to(() => MainScreen());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 54.5.w,
                        height: 30.5.h,
                        child: Image.asset(
                          "assets/images/Icon material-dashboard@2x.png",
                          scale: 2,
                          color: bottomcontroller.navigationBarIndexValue == 0
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: bottomcontroller.navigationBarIndexValue == 0
                              ? Colors.black
                              : Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _onItemTapped(1);
                        });
                      },
                      child: Container(
                        width: 54.5.w,
                        height: 30.5.h,
                        child: Image.asset(
                          "assets/images/Group 42@2x.png",
                          color: bottomcontroller.navigationBarIndexValue == 1
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: bottomcontroller.navigationBarIndexValue == 1
                            ? Colors.black
                            : Colors.white,
                      ),
                    )
                  ],
                ),
                // SizedBox(
                //   width: 60.w,
                // ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _onItemTapped(2);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 54.5.w,
                        height: 30.5.h,
                        child: Image.asset(
                          "assets/images/Icon feather-search@2x.png",
                          color: bottomcontroller.navigationBarIndexValue == 2
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: bottomcontroller.navigationBarIndexValue == 2
                              ? Colors.black
                              : Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _onItemTapped(3);
                    });
                    // showModalBottomSheet(
                    //   enableDrag: true,
                    //   clipBehavior: Clip.hardEdge,
                    //   isDismissible: true,
                    //   isScrollControlled: true,
                    //   barrierColor: Colors.transparent,
                    //   elevation: 15,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(15.r),
                    //       topRight: Radius.circular(15.r),
                    //     ),
                    //   ),
                    //   context: context,
                    //   builder: (context) => StatefulBuilder(
                    //     builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                    //       return SingleChildScrollView(
                    //         // controller: ModalScrollController.of(context),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               width: 427.w,
                    //               height: 280.h,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.only(
                    //                   topLeft: Radius.circular(15.r),
                    //                   topRight: Radius.circular(15.r),
                    //                 ),
                    //                 gradient: LinearGradient(
                    //                   begin: Alignment.bottomRight,
                    //                   end: Alignment.bottomLeft,
                    //                   colors: [
                    //                     Color(0xff1CC8FB),
                    //                     Color(0xff004DF2),
                    //                   ],
                    //                 ),
                    //               ),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.symmetric(horizontal: 20),
                    //                 child: ListView(
                    //                   children: [
                    //                     Column(
                    //                       children: [
                    //                         GestureDetector(
                    //                           onTap: () {
                    //                             Get.back();
                    //                           },
                    //                           child: Container(
                    //                             width: 101.w,
                    //                             height: 18.h,
                    //                             decoration: BoxDecoration(
                    //                               border: Border.all(
                    //                                 color: Color(0xff01023163).withOpacity(0.06),
                    //                               ),
                    //                               color: Color(0xff002B7A).withOpacity(0.4),
                    //                               borderRadius: BorderRadius.only(
                    //                                 bottomLeft: Radius.circular(15.r),
                    //                                 bottomRight: Radius.circular(15.r),
                    //                               ),
                    //                             ),
                    //                             // child:
                    //                             // Image.asset(
                    //                             //   "assets/images/Icon ionic-ios-arrow-down-1.png",
                    //                             //   scale: 5,
                    //                             //   color: Colors.white,
                    //                             // ),
                    //                           ),
                    //                         ),
                    //                         23.verticalSpace,
                    //                         Row(
                    //                           children: [
                    //                             Row(
                    //                               children: [
                    //                                 // Container(
                    //                                 //   child: Image.asset(
                    //                                 //     "assets/images/Icon awesome-spotifyGreen.png",
                    //                                 //     scale: 5,
                    //                                 //   ),
                    //                                 // ),
                    //                                 11.horizontalSpace,
                    //                                 Container(
                    //                                   child: Text(
                    //                                     "Spotify",
                    //                                     style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    //                                   ),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             255.horizontalSpace,
                    //                             GestureDetector(
                    //                               onTap: () {
                    //                                 Get.back();
                    //                               },
                    //                               child: Icon(
                    //                                 Icons.close,
                    //                                 color: Colors.white,
                    //                               ),
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     10.verticalSpace,
                    //                     Container(
                    //                       width: 280.w,
                    //                       child: ProgressBar(
                    //                         timeLabelType: TimeLabelType.totalTime,
                    //                         baseBarColor: Color(0xffFFFFFF),
                    //                         timeLabelTextStyle: TextStyle(
                    //                           color: Colors.transparent,
                    //                         ),
                    //                         thumbColor: Color(0xff3E40D3),
                    //                         progressBarColor: Color(0xff3E40D3),
                    //                         progress: Duration(milliseconds: 5),
                    //                         // buffered: Duration(milliseconds: 2000),
                    //                         total: Duration(milliseconds: 50),
                    //                         onSeek: (duration) {
                    //                           print('User selected a new time: $duration');
                    //                         },
                    //                       ),
                    //                     ),
                    //                     Row(
                    //                       children: [
                    //                         Container(
                    //                           width: 63.w,
                    //                           height: 63.h,
                    //                           // child: Image.asset("assets/images/NoPath - Copy (14).png"),
                    //                         ),
                    //                         20.horizontalSpace,
                    //                         Column(
                    //                           crossAxisAlignment: CrossAxisAlignment.start,
                    //                           children: [
                    //                             Text(
                    //                               "Stuck With You",
                    //                               style: TextStyle(
                    //                                 fontSize: 20.sp,
                    //                                 color: Colors.white,
                    //                                 fontWeight: FontWeight.w600,
                    //                               ),
                    //                             ),
                    //                             3.verticalSpace,
                    //                             Text(
                    //                               "Justin Bieber",
                    //                               style: TextStyle(
                    //                                 fontSize: 16.sp,
                    //                                 color: Colors.white,
                    //                                 fontWeight: FontWeight.w100,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         30.horizontalSpace,
                    //                         Container(
                    //                           width: 13.w,
                    //                           height: 13.h,
                    //                           // child: Image.asset("assets/images/Icon ionic-md-skip-forward-1.png"),
                    //                         ),
                    //                         16.horizontalSpace,
                    //                         Container(
                    //                           width: 46.w,
                    //                           height: 46.h,
                    //                           // child: Image.asset("assets/images/Group 1439.png"),
                    //                         ),
                    //                         16.horizontalSpace,
                    //                         Container(
                    //                           width: 13.w,
                    //                           height: 13.h,
                    //                           // child: Image.asset("assets/images/Icon ionic-md-skip-forward.png"),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     30.verticalSpace,
                    //                     Stack(
                    //                       alignment: Alignment.center,
                    //                       clipBehavior: Clip.none,
                    //                       children: [
                    //                         Container(
                    //                           width: 350.w,
                    //                           height: 1,
                    //                           color: Colors.grey,
                    //                         ),
                    //                         GestureDetector(
                    //                           behavior: HitTestBehavior.translucent,
                    //                           onTap: () {
                    //                             Get.toNamed("/SPOTIFYScreen");
                    //                           },
                    //                           child: Positioned(
                    //                             top: -20,
                    //                             child: Container(
                    //                               width: 142.w,
                    //                               height: 37.h,
                    //                               decoration: BoxDecoration(
                    //                                 color: Color(0xff002B7A).withOpacity(0.7),
                    //                                 borderRadius: BorderRadius.circular(20),
                    //                               ),
                    //                               child: Padding(
                    //                                 padding: const EdgeInsets.symmetric(
                    //                                   horizontal: 15,
                    //                                 ),
                    //                                 child: Row(
                    //                                   children: [
                    //                                     // Container(
                    //                                     //   child: Image.asset(
                    //                                     //     "assets/images/Icon awesome-spotifyGreen.png",
                    //                                     //     scale: 5,
                    //                                     //   ),
                    //                                     // ),
                    //                                     5.horizontalSpace,
                    //                                     Text(
                    //                                       "Open Spotify",
                    //                                       style: TextStyle(
                    //                                         fontSize: 12.sp,
                    //                                         color: Colors.white,
                    //                                       ),
                    //                                     )
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                     20.verticalSpace,
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // );

                    // setState(() {
                    //   _onItemTapped(4);
                    // });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 54.5.w,
                        height: 30.5.h,
                        child: Image.asset(
                          "assets/images/Icon feather-settings@2x.png",
                          color: bottomcontroller.navigationBarIndexValue == 3
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: bottomcontroller.navigationBarIndexValue == 3
                              ? Colors.black
                              : Colors.white,
                        ),
                      )
                    ],
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
